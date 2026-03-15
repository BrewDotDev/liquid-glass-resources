# Cloudflare cutover checklist

## Cloudflare Pages project

Create or verify a Pages project with these settings:

- Project type: Pages
- Production branch: `main`
- Framework preset: `None`
- Build command: `jekyll build`
- Build output directory: `_site`
- Root directory: `/`
- Environment variable on Preview: `RUBY_VERSION=3.1.3`
- Environment variable on Production: `RUBY_VERSION=3.1.3`

## Pre-cutover checks

- `main` contains commits `fe1a8ad`, `da75d1a`, and `743cdeb` or later equivalents
- Cloudflare preview deployment succeeds
- `npm run build:site && npm run smoke:site` succeeds locally
- Preview smoke checks:
  - homepage loads
  - search input renders
  - CSS loads
  - sitemap loads
  - `liquid-glass-css` page loads
  - representative development/design resource pages load

## DNS inventory before changes

Record the current DNS values before cutover:

- Registrar:
- Current nameservers:
- Apex A/AAAA records:
- `www` CNAME or A record:
- Existing TXT/CAA records:
- GitHub Pages custom domain setting:

## Cutover steps

1. Freeze content changes temporarily.
2. Ensure the Cloudflare zone for `liquidglassresources.com` exists in the target account.
3. If needed, switch registrar nameservers to Cloudflare.
4. In Cloudflare Pages, attach:
   - `liquidglassresources.com`
   - `www.liquidglassresources.com`
5. Set `liquidglassresources.com` as canonical and redirect `www` to apex.
6. Wait for HTTPS to become active for both hostnames.
7. Verify the production site manually.
8. Remove the custom domain from GitHub Pages.
9. Remove legacy GitHub Pages DNS records.

## Post-cutover checks

- `https://liquidglassresources.com` serves from Cloudflare with valid HTTPS
- `www` redirects to apex
- homepage loads correctly
- `https://liquidglassresources.com/liquid-glass-css` loads
- `https://liquidglassresources.com/development/flutter-liquid-glass-demo/` loads
- `https://liquidglassresources.com/design/framer-apple-liquid-button/` loads
- `https://liquidglassresources.com/sitemap.xml` loads
- Algolia search returns results
- PostHog events still ingest
- repo-internal files are not publicly reachable

## Rollback

If production fails after cutover:

1. Restore the previous GitHub Pages DNS targets.
2. Reattach the GitHub Pages custom domain.
3. Confirm the apex hostname resolves back to GitHub Pages.
4. Keep Cloudflare Pages deployed for debugging, but stop routing production traffic there.
