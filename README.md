# Liquid Glass Resources

A Jekyll-powered directory of Liquid Glass development and design resources.

## Stack

- Jekyll `4.3.3`
- Tailwind CSS `4`
- DaisyUI `5`
- Algolia search
- PostHog analytics

## Local development

### Prerequisites

- Ruby `3.1.3` (see `.ruby-version`)
- Bundler
- Node.js and npm

### Install dependencies

```bash
BUNDLE_FORCE_RUBY_PLATFORM=true BUNDLE_PATH=vendor/bundle bundle install
bun install
```

### Rebuild CSS

```bash
bun run build:css
```

### Run the site locally

```bash
bun run serve
```

The site will be available at `http://127.0.0.1:4000`.

## Production build

```bash
bun run build:site
bun run smoke:site
```

## CSS workflow

The production stylesheet is currently committed at `assets/dist-styles.css`.

Tailwind and DaisyUI are present in `package.json`. CSS can now be rebuilt locally with `bun run build:css`, but the production deploy pipeline still does not rebuild CSS automatically; keep CSS changes explicit until that is wired into deployment.

## Deployment

### Current production deployment

Production currently deploys from GitHub Actions to GitHub Pages using `.github/workflows/jekyll-gh-pages.yml`.

### Target deployment

The site is being migrated to Cloudflare Pages with:

- Production branch: `main`
- Build command: `jekyll build`
- Output directory: `_site`
- Environment variable: `RUBY_VERSION=3.1.3`
- Custom domains:
  - `liquidglassresources.com`
  - `www.liquidglassresources.com`

See `docs/cloudflare-pages-migration.md` for the implementation checklist, rollout plan, and rollback steps. Use `scripts/smoke-check.sh` after builds or previews to verify the expected pages and ensure repo-internal files are not being published.
