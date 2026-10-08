<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme Compiler lets a **theme** declare source assets (e.g. SCSS) that should be compiled on demand into a served file, using a compiler plugin from the `compiler` module. A theme ships a `THEME.theme_compiler.yml` describing which compiler to run over which files and what URL to serve the result at; the module builds the routes, compiles when needed, and serves the compiled bytes.

---

The module reads a `THEME.theme_compiler.yml` file from every enabled theme via `YamlDiscovery`. That file is keyed by **compiler plugin id** (e.g. `scss`), then by a **theme-relative target path**, whose value is a config array with `files` (required list of theme-relative source paths), optional `options` (passed to the compiler), and optional `data`. For each target, `RouteHelper` builds a dynamic route named `theme_compiler.<sha384-of-uri>` that maps the target's theme-relative URI to `theme_compiler.controller:serve` and stores a serialized `RefineableCompilerContext` as the `theme_compiler_context` route default. When that route is hit, the controller reads the pre-compiled file from the sandbox `public://theme-compiler-assets/<theme>/<path>` and returns it as a `CacheableResponse` (404/204 when missing/empty). Compilation itself happens in `theme_compiler.compiler` (`Drupal\theme_compiler\Compiler`), which for each route context runs the compiler plugin (letting modules and every enabled theme alter it via `hook_theme_compiler_alter` / `hook_theme_compiler_TYPE_alter`) and writes the result into the sandbox with cache-tag invalidation. Recompilation is triggered automatically on theme install/uninstall (`hook_themes_installed`/`uninstalled`), whenever a relevant `THEME.settings` config is saved or deleted (via `CompileSubscriber` on `ConfigEvents`), and on demand by dispatching `OnDemandCompileEvent`. The result: themes can author Sass/other sources and ship compiled CSS/JS without a build step in their release, as long as a matching compiler plugin (like `compiler_scss`) is installed.

---

- Let a theme ship SCSS and have it compiled to CSS on demand via the `scss` compiler plugin.
- Declare compiled asset targets in a `THEME.theme_compiler.yml` without a Node/Gulp build in CI.
- Serve a compiled theme asset from a stable theme-relative URL (its own route).
- Recompile theme assets automatically when the theme is installed or uninstalled.
- Recompile when a theme's settings (`THEME.settings`) change, so theme-setting-driven Sass variables update.
- Trigger a full recompile programmatically by dispatching `OnDemandCompileEvent`.
- Pass compiler options (e.g. output style) per target through the `options` key.
- Pass arbitrary `data` to the compiler for a target.
- Combine multiple source files into one compiled asset via the `files` list.
- Alter the compiler plugin or context before compilation with `hook_theme_compiler_alter()`.
- Alter compilation for a specific compiler with `hook_theme_compiler_TYPE_alter()`.
- Alter the served asset response with `hook_theme_compiler_response_alter()` (module or theme).
- Let a base theme's compiled assets recompile when a sub-theme's settings change (config dependencies).
- Store compiled output safely in a sandboxed public directory (`public://theme-compiler-assets/`).
- Cache-tag compiled assets (`theme_compiler_asset:<hash>`, `library_info`) for correct invalidation.
- Provide compiled assets that respond during maintenance mode (routes allow maintenance access).
- Build a themable, per-theme CSS pipeline shared across several themes on one site.
- Keep theme source (`.scss`) in the theme and let Drupal produce the deployable `.css`.
- Avoid committing compiled CSS to the theme repo by generating it at runtime.
- Reuse the generic `compiler` plugin framework specifically for theme assets.
- Prevent path escaping: targets are resolved and constrained beneath the sandbox path.
- Serve compiled assets with an appropriate cacheable 404/204 when not yet generated.
- Support multiple compilers (Sass, LESS, etc.) side by side, keyed by compiler id in the YAML.
