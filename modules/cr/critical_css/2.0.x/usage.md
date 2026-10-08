<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Critical CSS inlines a page-specific "critical" CSS file into the HTML `<head>` and loads the rest of the site's CSS asynchronously, removing render-blocking stylesheets to speed up first paint.

---

You generate critical CSS files ahead of time (e.g. with Addy Osmani's *critical* or Filament Group's *criticalCSS*) and drop them into a directory inside your active theme, configured on the settings page. For each request the `critical_css` service (`CriticalCssProvider`) picks the most specific matching file from that directory, trying, in order: `{entity_id}.css`, `path-{sanitized_path}.css`, `{sanitized_path}.css`, `path-{sanitized_path_info}.css`, `{sanitized_path_info}.css`, `{bundle}.css`, and finally `default-critical.css`. The matched file's contents are inlined in a `<style>` tag and every other stylesheet is rewritten to load asynchronously (via a decorator over core's `asset.css.collection_renderer`, class `CssCollectionRenderer`) using the Filament Group `media="print"`/`onload` pattern — no polyfill needed. It is deliberately **disabled on admin routes** (for users who can view the admin theme) and on AJAX requests, and disabled for logged-in users unless *Enabled for logged-in users* is on (critical CSS is generated emulating an anonymous visit). Settings (`critical_css.settings`): `enabled`, `dir_path` (must start with `/`, relative to the active theme, no `..`), `excluded_ids` (entity ids to skip, one per line), `enabled_for_logged_in_users`, and `preload_non_critical_css`. When Drupal CSS aggregation (`system.performance` `css.preprocess`) is on, the inlined CSS is run through core's CSS optimizer. A `hook_critical_css_file_paths_suggestion_alter()` hook lets you add or reorder candidate file paths. The module ships config schema but no config/install defaults, so it does nothing until you enable it and set a directory.

---

- Inline above-the-fold CSS for the front page to cut render-blocking requests and speed up first paint.
- Serve a per-content-type critical file (e.g. `article.css`) so each bundle gets tailored critical CSS.
- Provide a per-node critical file by entity id (e.g. `123.css`) for a hand-tuned landing page.
- Provide a per-URL critical file (e.g. `my-page-url.css`) for a specific path.
- Fall back to a single `default-critical.css` for every page without a more specific file.
- Load all non-critical stylesheets asynchronously to eliminate render-blocking CSS.
- Improve Largest Contentful Paint / First Contentful Paint scores on Lighthouse.
- Keep critical CSS disabled on `/admin` routes to avoid clashing with the admin theme.
- Exclude specific entity ids from critical CSS processing via `excluded_ids`.
- Turn the whole feature on or off with a single `enabled` flag without uninstalling.
- Optionally enable it for logged-in users when their pages match the anonymous render.
- Preload non-critical CSS (highest priority) to fix Flash-Of-Unstyled-Content when needed.
- Point the module at a theme subdirectory (e.g. `/css/critical`) where generated files live.
- Combine with a Gulp/CI step that regenerates critical CSS files on deploy.
- Add custom candidate file paths through `hook_critical_css_file_paths_suggestion_alter()`.
- Run inlined CSS through core's optimizer automatically when CSS aggregation is enabled.
- Debug matching by enabling Twig debug to see the candidate paths printed as an HTML comment.
- Speed up a marketing/landing page where above-the-fold styling is critical.
- Reduce time-to-first-paint on mobile where render-blocking CSS is most costly.
- Ship different critical CSS per theme by placing files under each theme's directory.
- Deploy critical CSS settings across environments through the `critical_css.settings` config.
- Avoid a JavaScript CSS-loading polyfill by using the module's native async strategy.
- Prevent AJAX responses from being altered by keeping the feature off for XHR requests.
