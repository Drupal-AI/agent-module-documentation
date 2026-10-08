<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SCSS/Less Compiler compiles `.scss`/`.less` files that a theme or module declares in its `*.libraries.yml` into CSS on the fly, so you can ship Sass sources in your libraries instead of pre-built CSS. It uses the bundled scssphp PHP compiler (no Node toolchain required).

---

The module hooks into Drupal's asset pipeline: `hook_library_info_alter()` tags any library CSS whose extension matches a configured compiler plugin, and `hook_css_alter()` swaps each source file for a freshly compiled CSS file (stored under `public://scss_compiler/…`), compiling it via the `scss_compiler` service when the output is missing or the source changed. When CSS caching is off it also recompiles everything on `hook_page_attachments_alter()`, checking file modification times to avoid needless work. Compilation is delegated to **ScssCompiler plugins** (a plugin type this module defines): `scss_compiler_scssphp` (default, for `.scss`), plus `scss_compiler_lessphp` and `scss_compiler_libsass`; the `plugins` setting maps a file extension to the plugin that handles it. Behaviour is controlled by the `scss_compiler.settings` config object — `output_format` (compressed/expanded/nested/compact/crunched), `sourcemaps`, `cache`, `check_modify_time`, `flush_cache_type`, `node_modules_path` — surfaced by altering the core **Performance** settings form (`configure: system.performance_settings`). You recompile by flushing the compiler cache: the `compiler:cr` Drush command (alias `ccr`), the `/admin/flush/scss_compiler` route, or a normal cache rebuild. Two alter hooks let code add `@import` search paths (`hook_scss_compiler_import_paths_alter`) and inject/override Sass variables per file, module or globally (`hook_scss_compiler_variables_alter`). The `scss_compiler` service also exposes `compile()`, `compileAll()`, `flushCache()` and `buildCompilationFileInfo()` for programmatic use.

---

- Ship a custom theme's Sass sources in `theme.libraries.yml` and let Drupal compile them to CSS.
- Develop with `.scss` files and see changes without running a Node/webpack build.
- Compile `.less` files by mapping the `less` extension to the `scss_compiler_lessphp` plugin.
- Switch compiled CSS to human-readable `expanded` output while developing, `compressed` for prod.
- Generate source maps (`sourcemaps: true`) so browser dev tools point back to the `.scss` source.
- Recompile all sources on demand with `drush ccr` (alias for `compiler:cr`).
- Add a "Flush compiler cache" toolbar/menu action via `/admin/flush/scss_compiler`.
- Import a Sass framework (e.g. Foundation) by adding its path in `hook_scss_compiler_import_paths_alter`.
- Override Sass variables globally (e.g. brand color) via `hook_scss_compiler_variables_alter`.
- Set different variable values per module/theme or per specific `.scss` file at compile time.
- Use `@namespace/path` tokens in libraries to import from another module/theme's Sass.
- Keep compiled CSS out of caching (`cache: false`) so edits show immediately during development.
- Only recompile changed files by leaving `check_modify_time` on for faster page builds.
- Control what a cache flush purges via `flush_cache_type` (default vs system).
- Compile Sass into CSS from custom code with `\Drupal::service('scss_compiler')->compile($info, TRUE)`.
- Recompile every registered source programmatically with `compileAll()` / `flushCache()`.
- Add a new compiler backend by writing an `@ScssCompilerPlugin` in `Plugin/ScssCompiler`.
- Serve compressed, minified CSS in production without a separate asset build step.
- Point the compiler at a `node_modules` directory for Sass imports (`node_modules_path`).
- Let non-front-end developers change styles by editing Sass without build tooling.
- Migrate a theme from committed CSS to maintainable Sass partials and `@import`s.
- Compile per-theme Sass so each active theme keeps its own compiled output list.
- Reset stale compiled CSS after changing output format by flushing the compiler cache.
