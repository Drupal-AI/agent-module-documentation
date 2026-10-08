<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SCSS/Less Compiler — agent index

Compiles `.scss`/`.less` declared in a `*.libraries.yml` into CSS automatically (via the
bundled scssphp library). No Node build. Config object: `scss_compiler.settings` (settings are
added to the core **Performance** form → `configure: system.performance_settings`). Defines a
**plugin type** `scss_compiler`. Provides a Drush command. No permissions of its own (routes
use `administer site configuration` / `administer site configuration`).

- **Settings keys, the Performance form, flush (route + `drush ccr`), how libraries get compiled**
  → [configure/settings.md](configure/settings.md)
- **The `scss_compiler` plugin type, the shipped compilers, adding one, the extension map**
  → [plugins/compiler-plugins.md](plugins/compiler-plugins.md)
- **The `scss_compiler` service API (`compile`, `compileAll`, `flushCache`, …)**
  → [api/service.md](api/service.md)
- **Alter hooks: import paths & Sass variables**
  → [hooks/alter-hooks.md](hooks/alter-hooks.md)

Key facts: `scss_compiler.settings` keys are `output_format`
(`compressed`|`expanded`|`nested`|`compact`|`crunched`), `sourcemaps`, `cache`,
`check_modify_time`, `flush_cache_type` (`default`|`system`), `node_modules_path`, and
`plugins` (extension → compiler id map, default `scss: scss_compiler_scssphp`; `less` commented
out). Compiled CSS lives under `public://scss_compiler/`. Recompile with `drush ccr`
(alias of `compiler:cr`) or `/admin/flush/scss_compiler`.
