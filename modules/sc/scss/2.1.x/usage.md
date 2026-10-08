<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SCSS Compiler builds a theme's (or module's) on-disk Sass/SCSS into CSS from inside Drupal using the pure-PHP scssphp library — no Node toolchain, no separate build step — recompiling automatically when a watched source file changes, or on demand from Drush or the settings form.

---

The module wraps `scssphp/scssphp` in a `scss.compiler` service (`Drupal\scss\Services\ScssCompiler`) and points it at a theme's source directory. Configuration lives at `/admin/config/development/scss` (route `scss.admin`, permission `administer site configuration`) in the `scss.settings` config object: you pick the **theme** (`theme_to_watch`, empty = the default theme), the **directory holding SCSS/SASS sources** (`scss_directory`, default `scss`, relative to each watched root), the **destination CSS directory** (`css_directory`, default `css`), optional **additional import paths** and **additional paths to watch** (e.g. a module), a **files-to-ignore** list, plus toggles for whether compilation is **active**, whether it also runs **for logged-out users** (`compile_logged_out`), the scssphp **output formatting** (`expanded`/`compressed`), and **source maps**. Only files whose names do not start with `_` and end in `.scss` are compiled (recursively). Recompilation is triggered by `ScssMonitor`, an event subscriber on `KernelEvents::REQUEST` that compiles when any watched source is newer than the per-directory `scss_last_compile_date_*` state value — so `compile_logged_out` matters: with it off, only authenticated traffic triggers rebuilds. The settings form also has Compile, Test (compile-to-screen), and Reset (reinstall defaults) buttons. For deployments there is a Drush command, `drush scss:compile` (aliases `scss`, `scss-c`, in `Commands\ScssCommands`), so compilation can be part of a release rather than a page request. `checkConfiguration()` verifies the scssphp library is loadable — falling back to a legacy `sites/all/libraries/scssphp/scss.inc.php` path — and that the source dir exists, the CSS dir is writable, and `.scss` files are present. Integrators can implement `hook_scss_preprocess_alter(&$stylesheet, $scss_full_path)` to rewrite the SCSS text before it is compiled.

---

- Compile a theme's Sass without installing Node or gulp.
- Let designers edit SCSS and see CSS regenerate on page load.
- Keep a build step out of the deployment pipeline.
- Compile SCSS on a host where npm/CLI access is unavailable.
- Generate source maps for debugging compiled styles.
- Choose compressed or expanded CSS output.
- Watch additional module/theme directories for changes.
- Ignore partials or vendor files during compilation.
- Add extra `@import` search paths for shared Sass libraries.
- Compile during deployment with `drush scss:compile`.
- Restrict recompilation to authenticated traffic to cut overhead.
- Recompile automatically when a watched source file changes.
- Support several themes by switching the configured theme.
- Prototype design changes directly on a dev site.
- Avoid committing compiled CSS to the repository.
- Inject SCSS variables globally via `hook_scss_preprocess_alter`.
- Preview compiled CSS on screen with the Test button before writing.
- Reset all settings to their defaults from the form.
- Use the compiled CSS through normal Drupal libraries.
- Track last-compile timestamps in state, per watched directory.
- Verify the scssphp library is present before compiling.
- Migrate a legacy site that used the old `sites/all/libraries` path.
