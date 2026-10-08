<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & operate the compiler

## Where the settings live

Config object **`scss_compiler.settings`**. There is no dedicated admin page — the module
alters the core **Performance** form (`scss_compiler_form_system_performance_settings_alter`),
so `configure: system.performance_settings` → `/admin/config/development/performance`. No
config schema ships (`provides_config_schema: false`).

`config/install/scss_compiler.settings.yml` defaults:

```yaml
cache: false                       # cache compiled CSS (skip recompiling on each build)
sourcemaps: true                   # emit <name>.css.map next to the CSS
output_format: 'compressed'        # compressed | expanded | nested | compact | crunched
flush_cache_type: 'default'        # default | system  (what a cache flush purges)
check_modify_time: true            # only recompile a source whose mtime changed
node_modules_path: ''              # optional path for node_modules Sass imports
plugins:
  scss: 'scss_compiler_scssphp'    # extension -> compiler plugin id
  # less: 'scss_compiler_lessphp'  # (commented out by default)
```

Set values with Drush:

```bash
drush cset scss_compiler.settings output_format expanded -y
drush cset scss_compiler.settings sourcemaps false -y
# enable .less compilation:
drush cset scss_compiler.settings plugins.less scss_compiler_lessphp -y
```

- **`output_format`** maps to a scssphp formatter class (Compressed/Expanded/Nested/Compact/
  Crunched); anything unrecognised falls back to Compressed.
- **`plugins`** is an **extension → plugin id** map. A file is compiled only if its extension
  is a key here. Add `less: scss_compiler_lessphp` to compile `.less`.
- **`flush_cache_type`** — `default`: on a system cache flush, keep compiled CSS if `cache`
  is on; `system`: always delete `public://scss_compiler` on flush.

## How files get compiled (no manual step)

1. Declare the Sass source in a `*.libraries.yml`, e.g.:

   ```yaml
   global:
     css:
       theme:
         css/style.scss: {}
   ```

2. `hook_library_info_alter()` tags the `.scss` file with its owning extension namespace.
3. `hook_css_alter()` replaces the source with a compiled file under
   `public://scss_compiler/<namespace>/…css`, compiling it when the output is missing or the
   source changed. With `cache: false`, `hook_page_attachments_alter()` also runs
   `compileAll()` each request (mtime-gated).

## Recompiling / flushing

- **Drush:** `drush compiler:cr` (alias **`drush ccr`**) → `flushCache()`.
- **Route:** `/admin/flush/scss_compiler` (`scss_compiler.flush`, permission
  `administer site configuration`, CSRF-protected) — redirects back to the referrer.
  A menu link "Flush compiler cache" is added under the admin toolbar.
- **Any full cache rebuild** (`drush cr`) also triggers `hook_cache_flush()`.

`flushCache()` deletes `public://scss_compiler`, recompiles all registered sources, and clears
the CSS aggregation.
