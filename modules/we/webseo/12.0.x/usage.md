Web SEO is a meta-package that installs and pre-configures the most commonly needed contrib SEO modules for a Drupal site in one step via a bundled recipe.

---

Web SEO (`webseo`, part of the Webship `web*` suite) is a thin convenience/meta-package: it carries almost no code of its own (two OOP hook classes) and instead depends — through `composer.json` — on a curated set of SEO contrib modules (Metatag, Schema.org Metatag, Pathauto, Token, Redirect, XML Sitemap, Yoast SEO, Easy Breadcrumb, Google Analytics, Google Tag). Enabling the module runs `recipes/default`, which installs those modules plus core `node`, `views`, `shortcut`, `language` and `user`, imports their default config, grants the content-editor role SEO permissions, and applies opinionated defaults (a "Menu Path" Pathauto pattern, a redirects admin View at `/admin/config/search/redirect`, redirect-404 handling, Schema.org breadcrumbs, front-page meta tags, 15-minute page caching and CSS/JS aggregation). Its two hooks make small runtime corrections: dropping an empty `[current-page:title]` token from browser titles, and stripping a stray `/core/install.php` segment from the stored XML sitemap base URL. Version 12.0.1 targets Drupal core `^11.4 || ^12` (D12 support added over the 11.0.x line). It has no settings form, permissions or routes of its own — the real UI belongs to the bundled modules.

---

- Bootstrap a site's SEO stack with a single module install.
- Pull in Metatag, Schema.org Metatag, Pathauto, Redirect, XML Sitemap, Yoast SEO, Easy Breadcrumb, Google Analytics and Google Tag together with pinned version constraints.
- Apply the bundled `recipes/default` recipe automatically on install (via `webseo_install()`).
- Provision a "Menu Path" Pathauto pattern (`/[node:menu-link:parents:join-path]/[node:title]`) for node URL aliases.
- Provide a redirects admin listing View at `/admin/config/search/redirect` with From/To/status-code/language filters and a bulk-operations form.
- Add a "Set up a redirect" shortcut linking to `/admin/config/search/redirect/add`.
- Enable redirect-404 logging and suppress 404 log noise (`suppress_404: true`).
- Grant the `content_editor` role the `administer redirects` permission plus core content-editor permissions.
- Configure Easy Breadcrumb to emit Schema.org `BreadcrumbList` JSON-LD and hide single-home-item breadcrumbs.
- Set default front-page meta tags (title `[site:name]`, canonical and shortlink `[site:url]`).
- Keep browser titles clean on title-less pages (log-out confirmation, etc.) by dropping the empty title token and its separator.
- Fix XML sitemap links generated during an installer-based install by removing the `/core/install.php` base-URL segment on cron.
- Turn on page caching (15 minutes) and CSS/JS aggregation as performance defaults.
- Import all default Metatag, Schema Metatag, Pathauto, Redirect, XML Sitemap, Yoast SEO, Google Analytics and Google Tag configuration.
- Provide a starting point for a Drupal 11/12 site that needs standard SEO out of the box.
- Serve as a site-building baseline you review and then trim to a project's needs.
- Standardise the SEO module set across multiple sites in an organisation.
- Save the manual work of requiring, enabling and wiring together ~10 SEO modules.
- Act as the SEO layer of the broader Webship distribution.
