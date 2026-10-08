<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declaring compiled assets: `THEME.theme_compiler.yml`

There is **no admin UI** (`configure: null`). All configuration is a YAML file shipped in a
**theme** directory. The module discovers `THEME.theme_compiler.yml` in every enabled theme
(`YamlDiscovery` over the theme directories).

## File structure

```yaml
# my_theme/my_theme.theme_compiler.yml
scss:                              # compiler plugin id (from the `compiler` manager)
  css/style.css:                   # target: theme-relative path the result is served at
    files:                         # REQUIRED: non-empty list of theme-relative source files
      - scss/style.scss
    options:                       # optional: passed to the compiler plugin
      style: compressed
    data: null                     # optional: arbitrary user data for the compiler
  css/admin.css:
    files: [scss/admin.scss]
```

- Top-level keys = **compiler plugin ids** (e.g. `scss`). A compiler plugin with that id must
  be registered by the `compiler` manager (e.g. install `compiler_scss` for `scss`).
- Second-level keys = **target paths**, theme-relative, where the compiled file is served.
- `files` is **required** and must be a non-empty array of strings; each is resolved with
  `realpath(DRUPAL_ROOT/<theme-path>/<file>)` at route-build time — a missing file throws
  `InvalidArgumentException` during route building, so keep paths valid.
- `options` (optional) must be an array; `data` (optional) is arbitrary.

## What gets built

For each target the module creates a route:

- Route name: `theme_compiler.<hash>` where `<hash> = sha384(/<theme-path>/<target-path>)`.
- Path: the theme-relative URI (`/<theme-path>/<target-path>`).
- Controller: `theme_compiler.controller:serve` (access `TRUE`, maintenance access `TRUE`).
- A serialized `RefineableCompilerContext` is stored as the `theme_compiler_context` default,
  carrying the compiler id, the `theme_compiler` option metadata (`theme`, `path`, `uri`,
  `id`), and `CompilerInputFile` inputs for each source file.

Routes are produced by the route callback `theme_compiler.route_helper:routes`
(`theme_compiler.routing.yml` is just `route_callbacks: ['theme_compiler.route_helper:routes']`).
After adding/editing the YAML, rebuild routes/caches (`drush cr`) so routes regenerate.

## Verifying

```bash
# List generated routes for theme compiler:
drush php:eval '$c=0; foreach(\Drupal::service("router.route_provider")->getAllRoutes() as $n=>$r){ if(strpos($n,"theme_compiler.")===0)$c++; } echo $c;'
```

Compiled bytes are written to `public://theme-compiler-assets/<theme>/<target-path>` and served
from the target URL; when not yet generated the controller returns a cacheable 404 (or 204 if
the file is empty).
