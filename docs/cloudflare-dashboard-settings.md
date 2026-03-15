# Cloudflare, GitHub, and DNS settings

This document is the operator-facing setup reference for moving `liquid-glass-resources` from GitHub Pages to Cloudflare Pages.

## 1) Cloudflare account and zone

Use the Cloudflare account that will own the `liquidglassresources.com` zone.

Requirements:

- The apex domain `liquidglassresources.com` must be a zone in the same Cloudflare account as the Pages project.
- If the domain is not already delegated to Cloudflare, switch the registrar nameservers to the Cloudflare nameservers assigned to the zone.
- Before custom-domain activation, verify there are no restrictive CAA records preventing Cloudflare certificate issuance.

## 2) Cloudflare Pages project settings

Create the Pages project from the GitHub repository:

- Account: Cloudflare account that owns `liquidglassresources.com`
- Product: Workers & Pages
- Action: Create application → Pages → Import an existing Git repository
- Git provider: GitHub
- Repository: `BrewDotDev/liquid-glass-resources`

Build settings:

- Project name: `liquid-glass-resources`
- Production branch: `main`
- Framework preset: `None`
- Root directory: `/`
- Build command: `jekyll build`
- Build output directory: `_site`

Environment variables:

- Preview:
  - `RUBY_VERSION=3.1.3`
- Production:
  - `RUBY_VERSION=3.1.3`

Recommended Pages options:

- Keep preview deployments enabled.
- If the preview URLs should not be public, protect previews with Cloudflare Access.
- After production is live, redirect the project `pages.dev` hostname to the custom domain.

## 3) Cloudflare custom domains

Attach both production hostnames in the Pages project:

- `liquidglassresources.com`
- `www.liquidglassresources.com`

Expected behavior:

- `liquidglassresources.com` is the canonical production hostname.
- `www.liquidglassresources.com` redirects to `https://liquidglassresources.com` with `301`.

Recommended implementation:

- Add both hostnames under Pages → Custom domains.
- Use Cloudflare Bulk Redirects for:
  - `www.liquidglassresources.com` → `https://liquidglassresources.com`
  - `<project>.pages.dev` → `https://liquidglassresources.com`
- For the `www` redirect helper record, create:
  - Type: `A`
  - Name: `www`
  - IPv4 address: `192.0.2.1`
  - Proxy status: `Proxied`

Bulk Redirect settings for both rules:

- Status: `301`
- Preserve query string: enabled
- Subpath matching: enabled
- Preserve path suffix: enabled
- Include subdomains: enabled only for the `pages.dev` redirect if desired

## 4) Cloudflare DNS settings

### If the zone is already in Cloudflare

Expected DNS state after attaching the Pages custom domains:

- Apex domain handled by Pages/Cloudflare in the zone
- `www` handled by Pages/Cloudflare in the zone or via redirect-support record

Manual cleanup after cutover:

- Remove legacy GitHub Pages records once Cloudflare is serving production traffic.
- Keep any unrelated MX/TXT/email records intact.
- Review CAA records and allow Cloudflare certificate issuance if needed.

### If the zone is not yet in Cloudflare

At the registrar:

- Update nameservers to the Cloudflare nameservers assigned to `liquidglassresources.com`.

In Cloudflare DNS:

- Recreate all non-web records before cutover if they are not imported automatically:
  - MX
  - SPF / DKIM / DMARC TXT records
  - verification TXT/CNAME records used by other services
  - any CAA records

After the Pages project custom domains are attached:

- Confirm the zone has the Pages-managed records required for apex and `www`.
- Do not manually point the apex at GitHub Pages after cutover.

### GitHub Pages records to remove after cutover

Remove the old GitHub Pages web-serving records only after Cloudflare Pages is confirmed healthy:

- Any apex `A` / `AAAA` records used for GitHub Pages
- Any `www` `CNAME` pointing to GitHub Pages / `github.io`
- Any other GitHub Pages-specific web records no longer needed

Do not remove:

- email records
- unrelated third-party verification records
- records required by other services on the domain

## 5) GitHub repository settings

### GitHub Pages

In the repository:

- Go to Settings → Pages
- During migration prep: leave the existing Pages configuration in place until Cloudflare production is verified
- After Cloudflare is live:
  - remove the custom domain from GitHub Pages
  - unpublish the GitHub Pages site, or set the publishing source to `None`

Target end state:

- GitHub Pages no longer serves the production domain
- The repository can keep GitHub Actions enabled for validation workflows
- The old deployment workflow can be removed after the rollback window closes

### GitHub Actions

Keep Actions enabled.

Expected workflows in repo:

- `.github/workflows/jekyll-build.yml` remains enabled for build validation
- `.github/workflows/jekyll-gh-pages.yml` remains temporarily available only until Cloudflare production is stable and rollback risk is low

Recommended sequence:

1. Keep both workflows while Cloudflare preview and cutover are in progress.
2. After Cloudflare production is stable for at least 24 hours, disable GitHub Pages serving.
3. Then remove or archive `.github/workflows/jekyll-gh-pages.yml`.

## 6) Exact cutover order

1. Confirm `main` is green on the Jekyll validation workflow.
2. In Cloudflare, create the Pages project from GitHub.
3. Set:
   - Production branch `main`
   - Build command `jekyll build`
   - Output directory `_site`
   - `RUBY_VERSION=3.1.3` on Preview and Production
4. Verify the `pages.dev` preview deployment.
5. Run local verification:
   - `npm run build:site`
   - `npm run smoke:site`
6. Attach `liquidglassresources.com` and `www.liquidglassresources.com` in the Pages project.
7. Configure Bulk Redirects:
   - `www` → apex
   - `pages.dev` → apex
8. Wait for active HTTPS on both custom domains.
9. Validate production manually:
   - homepage
   - sitemap
   - category pages
   - representative post pages
   - Algolia search
   - PostHog ingestion
10. Remove the custom domain from GitHub Pages.
11. Unpublish GitHub Pages or set publishing source to `None`.
12. Remove legacy GitHub Pages DNS records.
13. After 24h stability, remove `.github/workflows/jekyll-gh-pages.yml`.

## 7) Copy/paste checklist

### Cloudflare Pages

- [ ] Account selected correctly
- [ ] Zone `liquidglassresources.com` exists in same account
- [ ] Repo connected: `BrewDotDev/liquid-glass-resources`
- [ ] Production branch: `main`
- [ ] Framework preset: `None`
- [ ] Root directory: `/`
- [ ] Build command: `jekyll build`
- [ ] Output directory: `_site`
- [ ] Preview env var: `RUBY_VERSION=3.1.3`
- [ ] Production env var: `RUBY_VERSION=3.1.3`
- [ ] Custom domain attached: `liquidglassresources.com`
- [ ] Custom domain attached: `www.liquidglassresources.com`

### Cloudflare Redirects

- [ ] Bulk redirect `www.liquidglassresources.com` → `https://liquidglassresources.com` (`301`)
- [ ] Bulk redirect `<project>.pages.dev` → `https://liquidglassresources.com` (`301`)
- [ ] Query strings preserved
- [ ] Path suffix preserved
- [ ] Subpath matching enabled

### GitHub

- [ ] Actions enabled
- [ ] Build validation workflow green
- [ ] GitHub Pages custom domain removed after cutover
- [ ] GitHub Pages unpublished or source set to `None`
- [ ] `jekyll-gh-pages.yml` removed only after stability window

### DNS

- [ ] Nameservers point to Cloudflare if apex is being served by Pages
- [ ] Legacy GitHub Pages records removed after cutover
- [ ] Non-web records preserved
- [ ] CAA records reviewed
