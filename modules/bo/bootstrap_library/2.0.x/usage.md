<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Library registers the Bootstrap CSS/JS framework as a Drupal asset library and attaches it to page requests, with per-theme and per-path visibility rules and a choice between locally installed files (minified, source or Composer layout) and a pinned CDN version.

---

The module is a single settings form plus two hook implementations. `hook_page_attachments()` reads `bootstrap_library.settings`, checks the theme rule (`theme.visibility` + `theme.themes`) and the path rule (`url.visibility` + `url.pages`), and if both pass attaches one library: `bootstrap_library/bootstrap-cdn` when `cdn.bootstrap` is a version string, otherwise `bootstrap_library/bootstrap` (minified), `bootstrap_library/bootstrap-dev` (source) or `bootstrap_library/bootstrap-composer` depending on `minimized.options` (0 = source, 1 = minified, 2 = composer). The three local libraries are declared in `bootstrap_library.libraries.yml` and point at `/libraries/bootstrap/{css,js}/bootstrap[.min].{css,js}` (or `/libraries/bootstrap/dist/...` for the Composer variant), each depending on `core/jquery`. The CDN library is built at runtime by `hook_library_info_build()`, which JSON-decodes `cdn.options` (a blob of jsDelivr/StackPath/MaxCDN URLs for Bootstrap 2.0.4 → 5.2.3 that the settings form stores in a hidden field) and turns the selected version's `css`/`js` entries into external assets. Path matching lowercases both the internal path and its alias and runs them through `path.matcher`; `url.visibility` 0 means "all pages except those listed", 1 means "only the listed pages". Theme matching compares the active theme name against `theme.themes` with the same invert semantics. A `?bootstrap=no` query string disables the attachment for a single request. The settings form lives at `/admin/config/development/bootstrap_library` (route `bootstrap_library.admin`, permission *administer site configuration*). Two caveats worth knowing: the `files.types` setting (CSS/JS checkboxes) is saved but never consulted by the attachment logic, and `config/schema/bootstrap_library.schema.yml` is malformed (the nested keys are missing their `mapping:` level), so the settings are effectively schema-less.

---

- Load Bootstrap 5 site-wide for a custom theme that does not bundle the framework itself.
- Add Bootstrap to a contributed theme that only ships partial framework support.
- Serve Bootstrap from a CDN in production while keeping the site codebase free of the library.
- Pin an exact Bootstrap version (e.g. 5.2.3, 4.6.0, 3.3.7) through the CDN selector.
- Switch from CDN to a locally installed copy for offline or air-gapped environments.
- Use the non-minified Bootstrap build in development for readable stack traces.
- Use the minified build in production for smaller payloads.
- Point at the Composer-installed `twbs/bootstrap` layout (`/libraries/bootstrap/dist/...`).
- Keep Bootstrap off admin pages so it cannot clash with Claro/Gin styling.
- Exclude node add/edit forms and `system/ajax` from Bootstrap loading (the shipped defaults).
- Load Bootstrap only on a marketing landing page and its children.
- Load Bootstrap only on the front page while the rest of the site uses another framework.
- Restrict Bootstrap to one theme in a multi-theme site (e.g. front-end only, not admin).
- Invert the theme rule to load Bootstrap everywhere *except* a legacy theme.
- Debug a CSS conflict by disabling Bootstrap for one request with `?bootstrap=no`.
- Give a Layout Builder / Paragraphs page builder the Bootstrap grid without theme changes.
- Provide Bootstrap's JS (dropdowns, modals, collapse) to markup produced by a WYSIWYG.
- Standardise the Bootstrap version across many sites by shipping the exported settings config.
- Stage a Bootstrap 4 → 5 upgrade by flipping the CDN version and testing before committing.
- Add Bootstrap to a decoupled-ish admin tool built as a Drupal route.
- Prevent the library from loading during site install (the module skips `InstallerKernel`).
- Manage Bootstrap once instead of duplicating `libraries.yml` entries in several custom modules.
- Let a site builder change which pages Bootstrap loads on without a deployment.
- Ship Bootstrap to only the authenticated-facing pages listed in the path settings.
- Roll back a broken CDN edge by switching `cdn.bootstrap` back to "Load locally".
