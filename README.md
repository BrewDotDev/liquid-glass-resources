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
bundle install
npm install
```

### Run the site locally

```bash
bundle exec jekyll serve
```

The site will be available at `http://127.0.0.1:4000`.

## Production build

```bash
bundle exec jekyll build -d _site
```

## CSS workflow

The production stylesheet is currently committed at `assets/dist-styles.css`.

Tailwind and DaisyUI are present in `package.json`, but the deploy pipeline does not rebuild CSS automatically yet. Keep CSS changes explicit until the build is automated in a follow-up change.

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

See `docs/cloudflare-pages-migration.md` for the implementation checklist, rollout plan, and rollback steps.
