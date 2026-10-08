<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome Static renders every public-facing path of a Drupal site to static HTML files, so the whole site can be served as flat files from any host with no PHP or database in production.

---

Tome Static crawls the site, collecting paths from routes, entities, pagers, redirects, media oEmbed, and language variants (each contributed by an event subscriber), then renders each path in an isolated internal request and writes the resulting HTML — plus referenced assets and image-style derivatives — into the static directory (`tome_static_directory`, default `../html`). The main entry point is `drush tome:static` (pass `--uri=https://your-site` so absolute URLs are correct); it fans work out across worker processes (`tome:static-export-path`) using `--process-count` / `--path-count`, and can filter with `--path-pattern`. `drush tome:preview` serves the built directory with PHP's built-in server. An admin UI under `/admin/config/tome/static` (permission `use tome static`) offers Generate, Download, and Preview forms for non-CLI use. The build guards concurrency and records progress in state keys `tome_static.building` and `tome_static.url`. Its own cache bin (`cache.tome_static`) stores rendered output so unchanged paths are skipped on later builds. Behavior is extended with the `TomeStaticEvents` events (collect/replace paths, modify HTML, change destination, react to saved files) rather than configuration; there is no config object of its own (directories come from `settings.php`).

---

- Generate a complete static HTML copy of a Drupal site for production with `drush tome:static`.
- Serve a hardened, database-free site on Netlify, S3, GitHub Pages, or any static host.
- Preview the generated static build locally with `drush tome:preview`.
- Export only a subset of paths with `drush tome:static --path-pattern=...`.
- Speed up large builds by tuning `--process-count` and `--path-count`.
- Retry transient render failures with `--retry-count`.
- Pass the correct production domain with `--uri` so absolute links resolve.
- Let editors trigger a build from the admin UI at `/admin/config/tome/static/generate`.
- Download the latest static build as an archive from the admin UI.
- Restrict who can generate static HTML via the `use tome static` permission.
- Exclude system/admin paths from generation with `tome_static_path_exclude` in settings.php.
- Keep certain paths uncached with `tome_static_cache_exclude`.
- Add custom paths to the crawl by subscribing to `tome_static.collect_paths`.
- Rewrite generated HTML (e.g. asset rewriting) via `tome_static.modify_html`.
- Change where a page is written on disk via `tome_static.modify_destination`.
- React to each written file via `tome_static.file_saved`.
- Statically export paginated listing pages (pager subscriber follows the pages).
- Statically export redirects so they still work on a static host (with the redirect module).
- Statically export media oEmbed thumbnails and image-style derivatives.
- Export a multilingual site with each language's paths included.
- Re-run builds incrementally, skipping unchanged paths via the Tome Static cache bin.
- Combine with tome_static_cron to build on cron, or tome_static_super_cache for longer-lived caches.
- Check whether a build is in progress by reading the `tome_static.building` state key.
- Recall the last build's base URL from the `tome_static.url` state key.
- Ship a decoupled/JAMstack front end backed by Drupal-rendered static pages.
