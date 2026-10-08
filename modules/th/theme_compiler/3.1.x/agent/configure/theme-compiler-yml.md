<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declaring compiled assets: `THEME.theme_compiler.yml`

There is **no admin UI** (`configure: null`). All configuration is a YAML file shipped in a
**theme** directory. The module discovers `THEME.theme_compiler.yml` in every enabled theme
(`YamlDiscovery` over the theme directories, in `AssetDiscovery`).

## File structure

```yaml
# my_theme/my_theme.theme_compiler.yml
style.css:                       # TARGET path, theme-relative, where output is written/served
  plugin: scss                   # REQUIRED: compiler plugin id (from the `compiler` manager)
  source:                        # REQUIRED: non-empty list of theme-relative source files
    - scss/main.scss
css/admin.css:
  plugin: scss
  source:
    - scss/admin.scss
```

- Top-level keys = **target paths** (theme-relative). Each must be a safe relative path made of
  `[A-Za-z0-9._~-]` segments with **no `.` or `..` segment** — invalid keys throw a
  `RuntimeException` at discovery time. The compiled file is written to
  `<asset_storage_path>/<theme>/<target>` (default `public://compiled-assets/<theme>/<target>`).
- `plugin` (**required**) = a compiler plugin id that is **registered** with the `compiler`
  manager (e.g. install `compiler_scss` for `scss`); an unknown id throws, listing the
  available plugins.
- `source` (**required**) = a non-empty list of strings, each a theme-relative source file. Each
  is resolved with `realpath(DRUPAL_ROOT/<theme-path>/<file>)` and must be an existing file — a
  missing file throws a `RuntimeException` during discovery.

This is a **breaking change from 2.x**: the old shape keyed by compiler id then a target with
`files`/`options`/`data` is gone. Now the target is the top key, the compiler is `plugin`, and
the file list is `source`. There are no per-target `options`/`data` keys — use
`hook_theme_compiler_TYPE_alter()` to configure the compiler (e.g. output style, variables).

## What happens

For each target the module builds an `Asset` (id = `sha384("<theme>/<target>")`) and, on the
right trigger, compiles it and writes the bytes to
`<asset_storage_path>/<theme>/<target>`. There is **no route** — the output is a normal file
served by the web server at its public URL (get that URL with `file_url_generator`). When the
file does not exist yet, requesting it is a plain 404 from the web server.

Compilation runs on: **theme install/uninstall**, and **`THEME.settings` config save / rename /
delete** for a theme that defines assets (or is a sub-theme of one). It is **not** compiled on
an arbitrary cache rebuild — install the theme or change its settings to (re)generate. The
discovered definitions are cached (`theme_compiler_assets` cache tag); `drush cr` clears that
cache so edited YAML is re-read on the next compile trigger.

## Verifying

```bash
# Show the resolved asset storage path:
drush php:eval 'echo \Drupal::getContainer()->getParameter("theme_compiler.asset_storage_path");'

# List discovered assets (id => target) for all themes:
drush php:eval 'foreach (\Drupal::service("theme_compiler.asset_discovery")->getDefinitions() as $a) { echo "$a->provider  $a->plugin  $a->target\n"; }'
```

Compiled bytes are written to `public://compiled-assets/<theme>/<target>` and fetched from that
file's public URL. Reinstall the theme or resave its `*.settings` config to force a recompile.
