# Static Suite — manual setup guide

**Static Suite** (`static_suite`) turns Drupal into the back end of a decoupled,
static-site pipeline. It exports your Drupal data to static files, builds a static
site from them with a Static Site Generator (Gatsby, Next.js, Eleventy, Hugo,
Astro), and deploys the result to any host or CDN (AWS S3, Netlify, and so on).
The whole export → build → deploy flow is orchestrated from inside Drupal, and it
even includes an instant preview system for Gatsby — giving you the features of a
service like Gatsby Cloud (previews, fast and incremental builds) without relying
on any external service.

The suite is deliberately layered into submodules that you enable bottom-up:

- **Static Export** (`static_export`) — serializes entities, config and locale to
  data files (JSON, XML, YAML) through pluggable data resolvers (GraphQL, JSON:API,
  or a JSON serializer), and re-exports automatically when content changes.
- **Static Build** (`static_build`) — runs your chosen SSG as a background process
  to build the site.
- **Static Deploy** (`static_deploy`) — pushes the built release to a host or CDN.
- **Static Preview** (`static_preview`, plus `static_preview_gatsby_instant`) —
  previews content without a full rebuild.

Releases are managed as timestamped directories with a `current` symlink that is
swapped atomically when you publish, and a configurable number of past releases is
kept for rollback. The base module depends on core's Locale module.

This is **not a beginners' module** — its own documentation says as much. To get
real value from it you should be comfortable with decoupled Drupal, and you should
expect some instability while the project matures. It is best treated as a
framework you adapt to your project rather than a turnkey feature.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer command,
   and which submodules to enable for a basic working pipeline.
2. [Configuration](configuration/index.md) — the settings, the layers, releases,
   and the access model.

## Where it lives in the admin menu

Configuration lives under **Configuration → Static**
(`/admin/config/static`, settings route `static_suite.settings`). Build, deploy,
and export progress is surfaced in the admin toolbar, and logs live under
`/admin/reports/static/*`. All the settings and export/build/deploy configuration
forms require the **Administer site configuration** permission.
