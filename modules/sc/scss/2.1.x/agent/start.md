<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SCSS Compiler (scss) — agent index

Compiles a theme's (or module's) on-disk SCSS/SASS to CSS from inside Drupal using the pure-PHP
`scssphp/scssphp` library — no Node/gulp build step. Recompiles on page request when a watched
source file changed, or on demand via Drush / the settings form. No module dependencies, defines
no permissions of its own.

- **configure route:** `scss.admin` → `/admin/config/development/scss`
- Provides Drush commands (`scss:compile`); ships config schema; no plugin types; no submodules.

## Solutions
- **Set the theme/dirs/output and compile manually** → [configure/settings.md](configure/settings.md)
- **Compile from the CLI (deploy step)** → [drush/commands.md](drush/commands.md)
- **Call the compiler service from code / understand runtime triggering** → [api/compiler.md](api/compiler.md)
- **Mutate SCSS source before it is compiled (alter hook)** → [hooks/scss_preprocess.md](hooks/scss_preprocess.md)

## Key facts
- Config object: `scss.settings`. Keys: `active`, `compile_logged_out`, `theme_to_watch`,
  `scss_directory` (default `scss`), `css_directory` (default `css`), `additional_import_paths`,
  `additional_paths_to_watch`, `files_to_ignore`, `output_formatting` (default `expanded`),
  `source_maps` (default TRUE), `line_numbers` (unused).
- Route `scss.admin` → `Form\ScssSettingsForm`, permission `administer site configuration`.
- Services:
  - `scss.compiler` → `Services\ScssCompiler` (`ScssCompilerInterface`); args `@config.factory`,
    `@request_stack`, `@state`. Public props `$force`, `$testing`. Methods `compileScss()`,
    `checkConfiguration()`, `getListToCompile()`, `getScssFilesList()`, `compileNeeded()`.
  - `scss.monitor` → `Services\ScssMonitor`, an `event_subscriber` on `KernelEvents::REQUEST`
    (`compileIfNeeded`) — recompiles are triggered by page requests, not cron.
- Drush: `scss:compile` (aliases `scss`, `scss-c`) in `Commands\ScssCommands`, registered via
  `drush.services.yml`. A legacy Drush-8 `scss.drush.inc` also exists (broken on modern Drush).
- Alter hook the module invokes: `hook_scss_preprocess_alter(&$stylesheet, $scss_full_path)`
  (fired for both themes and modules) — lets integrators rewrite SCSS text before compilation.
- Last-compile timestamps live in **state** under `scss_last_compile_date_<dir>` (`/` → `%`).
- Library check: `checkConfiguration()` requires `\ScssPhp\ScssPhp\Compiler` (composer
  `scssphp/scssphp:^2`), falling back to a legacy `sites/all/libraries/scssphp/scss.inc.php`.

```bash
drush cget scss.settings
drush scss:compile        # or: drush scss
drush sget scss_last_compile_date_<theme_path>
```
