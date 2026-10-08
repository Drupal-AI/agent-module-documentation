# Configure — settings form & config

**Route:** `scss.admin` → `/admin/config/development/scss` (permission `administer site configuration`).
**Form:** `Drupal\scss\Form\ScssSettingsForm` (`getFormId()` = `scss_settings_form`).
**Config object:** `scss.settings` (schema `config/schema/scss.schema.yml`).

## Config keys

| Key | Type | Install default | Meaning |
|-----|------|-----------------|---------|
| `active` | boolean | `FALSE` | Master switch. When off, the request-time monitor never compiles. |
| `compile_logged_out` | boolean | *(unset → falsey)* | If off, only authenticated requests trigger the request-time compile. |
| `theme_to_watch` | string | *(empty)* | Theme machine name; empty falls back to `system.theme:default`. |
| `scss_directory` | string | `scss` | Source dir name, relative to each watched root (e.g. `scss`/`sass`). |
| `css_directory` | string | `css` | Destination dir name, relative to each watched root. Must be writable. |
| `additional_import_paths` | string (textarea, one/line) | `''` | Extra `@import` search paths (theme dir is prepended). |
| `additional_paths_to_watch` | string (textarea, one/line) | `''` | Extra root paths (full path from web root) to compile & watch, e.g. a module. |
| `files_to_ignore` | string (textarea, one/line) | `''` | Full paths of `.scss` files to skip. |
| `output_formatting` | string | `expanded` | A `ScssPhp\ScssPhp\OutputStyle` value: `expanded` or `compressed`. |
| `source_maps` | boolean | `TRUE` | Write a `.css.map` alongside each compiled `.css`. |
| `line_numbers` | boolean | `false` | Present in schema/install but **not read** by the form or compiler (no-op). |

Notes on file selection: only files whose name does **not** start with `_` and whose extension is
`.scss` are compiled (partials starting `_` are skipped, as are `files_to_ignore` entries). The
compiler globs the source dir recursively (`getScssFilesList()`).

## Form buttons (in `validateForm()` / `submitForm()`)

- **Compile and write** (`#name` = `compile`) — sets `$compiler->force = TRUE`, `testing = FALSE`,
  runs `compileScss()`, writing `.css`/`.css.map` to `css_directory`.
- **Test** (`#name` = `test`) — sets `force = TRUE`, `testing = TRUE`; compiles but prints the
  resulting CSS as a message instead of writing files.
- **Reset** (`#name` = `reset`) — re-installs default config via
  `config.installer` `installDefaultConfig('module', 'scss')`.
- **Save** — writes all clean form values into `scss.settings`, then calls `checkConfiguration()`.

The form header shows the last-compile date per watched dir (from state) and the list of files
that will compile.

## Set config without the UI

```bash
drush cset scss.settings active 1 -y
drush cset scss.settings compile_logged_out 0 -y
drush cset scss.settings theme_to_watch mytheme -y
drush cset scss.settings scss_directory scss -y
drush cset scss.settings css_directory css -y
drush cset scss.settings output_formatting compressed -y
```

```php
\Drupal::configFactory()->getEditable('scss.settings')
  ->set('active', TRUE)
  ->set('theme_to_watch', 'mytheme')
  ->set('output_formatting', 'compressed')
  ->save();
```

## Runtime behavior

With `active` on, `scss.monitor` (subscriber on `KernelEvents::REQUEST`) calls
`ScssCompiler::compileScss()` on each page load; it early-returns for anonymous users unless
`compile_logged_out` is set. `compileScss()` only rebuilds when `compileNeeded()` sees a source
file newer than the stored `scss_last_compile_date_<dir>` state value (or when forced). For
production, leave `compile_logged_out` off and drive builds from Drush instead
(see [../drush/commands.md](../drush/commands.md)); the compiler internals are in
[../api/compiler.md](../api/compiler.md).
