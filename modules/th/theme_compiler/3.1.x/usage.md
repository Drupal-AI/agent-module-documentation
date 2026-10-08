<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme Compiler lets a **theme** declare source assets (e.g. SCSS) that are compiled on demand into a plain file under the public files directory, using a compiler plugin from the `compiler` module. A theme ships a `THEME.theme_compiler.yml` describing which compiler to run over which source files and what target path the result is written to; the module compiles the sources and writes the output where the web server serves it as an ordinary static file — no Drupal route or controller is involved.

---

The module discovers a `THEME.theme_compiler.yml` file in every enabled theme via `YamlDiscovery` (`AssetDiscovery`). That file is keyed by **target path** (theme-relative, e.g. `style.css` or `css/style.css`); each entry is a definition with a required `plugin` (the compiler plugin id, e.g. `scss`) and a required non-empty `source` list of theme-relative file paths. `AssetDiscovery` validates each entry — the target key must be a safe relative path (no `.`/`..` segments), the plugin must be registered with the `compiler` manager, and every source file must resolve to a real file — and builds an `Asset` value object (id = `sha384("<theme>/<target>")`, target = `<asset_storage_path>/<theme>/<target>`); the definition list is cached in `cache.default` under `theme_compiler_assets`. `AssetCompiler` (`theme_compiler.compiler`, marked `@api`) does the work: for each asset it creates the compiler plugin, wraps each source in a `CompilerInputFile`, lets modules and the providing theme (plus its base themes) mutate the plugin via `hook_theme_compiler_TYPE_alter`, runs `$plugin->compile(...$inputs)`, prepares the target directory, and writes the bytes with `saveData(..., FileExists::Replace)`; it then fires `hook_theme_compiler_asset_updated`. Compilation is triggered automatically on theme install/uninstall (`hook_themes_installed`/`uninstalled`) and whenever a relevant `THEME.settings` config is saved, renamed, or deleted (via `CompileSubscriber` on `ConfigEvents`, which recompiles for themes that define assets and their sub-themes). Per-asset exceptions are logged and shown as a messenger error but never fatal. The output lands at `public://compiled-assets/<theme>/<target>` (path configurable via the `theme_compiler.asset_storage_path` container parameter) and is fetched at that file's normal public URL. The result: themes can author Sass/other sources and ship deployable CSS/JS without a Node build step in their release, as long as a matching compiler plugin (like `compiler_scss`) is installed.

---

- Let a theme ship SCSS and have it compiled to CSS on demand via the `scss` compiler plugin.
- Declare compiled asset targets in a `THEME.theme_compiler.yml` without a Node/Gulp build in CI.
- Serve a compiled theme asset as an ordinary static file from the public files directory.
- Recompile theme assets automatically when the theme is installed or uninstalled.
- Recompile when a theme's settings (`THEME.settings`) are saved, renamed, or deleted, so theme-setting-driven Sass variables update.
- Combine multiple source files into one compiled asset via the `source` list.
- Choose the compiler per target with the `plugin` key (`scss`, or any registered compiler plugin id).
- Alter the compiler plugin before compilation with `hook_theme_compiler_TYPE_alter()` (e.g. set output style or inject Sass variables from theme settings).
- React to a completed compile with `hook_theme_compiler_asset_updated()` (e.g. copy or post-process the output).
- Let a theme feed its own settings into Sass variables so admins can tune the compiled CSS.
- Let a base theme's compiled assets recompile when a sub-theme's settings change (config dependencies).
- Keep theme source (`.scss`) in the theme and let Drupal produce the deployable `.css` at runtime.
- Avoid committing compiled CSS to the theme repo by generating it on install/config change.
- Store compiled output under a configurable public path (`public://compiled-assets/` by default) via the `theme_compiler.asset_storage_path` parameter.
- Cache the discovered asset definitions (`theme_compiler_assets` cache tag) so discovery isn't re-run each request.
- Reuse the generic `compiler` plugin framework specifically for theme assets.
- Support multiple compilers (Sass, LESS, etc.) side by side, one `plugin` per target.
- Prevent path escaping: target keys are validated to reject `.`/`..` segments before anything is written.
- Build a per-theme CSS pipeline shared across a base theme and its sub-themes on one site.
- Let modules (not just themes) globally alter the compiler for a given plugin type via `hook_theme_compiler_TYPE_alter()`.
- Fail safe: a broken asset definition logs an error and shows a messenger warning instead of breaking the page.
