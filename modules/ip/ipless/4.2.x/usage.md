<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Less (machine name `ipless`) compiles Less (`.less`) stylesheets declared in a module's or theme's `*.libraries.yml` into CSS, using the pure-PHP `wikimedia/less.php` parser — no Node.js toolchain required.

---

You declare Less files under a `less:` key in a library definition (optionally with an `output:` target), enable the feature on the site's Performance page, and Simple Less generates the compiled CSS into `public://ipless/` and swaps it into the library's `css` at render time. Its settings are **not** a config entity of its own — the module alters core's `system.performance` config (adding an `ipless` mapping via `hook_config_schema_info_alter()`) with four booleans: `enabled`, `modedev` (dev mode: recompile on every request), `sourcemap`, and `watch_mode` (live-refresh CSS without reloading the page, dev-mode only). `hook_library_info_alter()` rewrites every `less` library entry to an output CSS uri (`public://ipless/{extension}-{library}--{file}.css`) when enabled, and strips the `less` key when disabled. Compilation happens in a response subscriber (`HtmlResponseIplessSubscriber`, priority 4 on `kernel.response`): in dev mode it compiles the libraries used on the current page, and when a full rebuild is flagged (state key `ipless.force_rebuild`, set on cache flush) it regenerates everything. A Drush command `ipless:generate` (alias `ipless`) precompiles all libraries. The module also fires an `ipless.file_compilation` event and invites a `hook_less_alter()` for tweaking Less parsing. The `configure` route is core's `system.performance_settings`.

---

- Compile a theme's `styles.less` into CSS without installing Node, Gulp, or a Sass/Less CLI.
- Declare Less files in `mytheme.libraries.yml` under a `less:` key and let Drupal build the CSS.
- Route compiled output to a specific file with `less: { css/styles.less: { output: css/gen/styles.css } }`.
- Turn on "Less compilation enabled" on `/admin/config/development/performance` to activate the feature.
- Use developer mode (`modedev`) to recompile Less on every page load while actively styling.
- Enable watch mode so edited Less refreshes in the browser without a manual reload (dev mode only).
- Generate source maps for Less files during development to debug compiled CSS.
- Precompile all site Less libraries in a deploy step with `drush ipless:generate`.
- Regenerate CSS automatically after a `drush cr` (cache flush flags a rebuild via `ipless.force_rebuild`).
- Ship a contrib module that authors styles in Less and compiles them on the target site.
- Keep authored Less in version control while serving generated CSS from `public://ipless/`.
- Compile only the Less libraries actually attached to the current page in dev mode for fast iteration.
- Add variables/mixins across a theme's Less files and have them resolved at build time.
- Migrate a legacy Less-based theme to Drupal 10/11 without changing the styling workflow.
- Alter Less parser configuration programmatically via `hook_less_alter()`.
- React to each Less compilation with a subscriber on the `ipless.file_compilation` event.
- Serve production sites plain compiled CSS (feature can stay enabled while dev/watch modes stay off).
- Flush and rebuild all compiled Less files by clearing caches.
- Provide per-environment behaviour: dev mode + watch on local, plain compilation on production.
- Compile Less that lives in module libraries as well as theme libraries.
- Avoid committing generated CSS by generating it on demand from source Less.
- Let site builders enable Less compilation entirely from the admin UI, no CLI needed.
- Use the `Ipless` service (`ipless.base`) from custom code to trigger `generateAllLibraries()`.
- Keep the CSS bandwidth-optimization pipeline (aggregation/minification) working on the generated files.
