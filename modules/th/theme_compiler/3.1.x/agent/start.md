<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme Compiler — agent index

Compiles **theme-provided** source assets (via a `compiler` plugin such as `scss`) into files
written under the public files directory and served as **ordinary static files** — no Drupal
route or controller. A theme declares targets in `THEME.theme_compiler.yml`; this module
discovers them, compiles on the right triggers, and writes the result to disk. No config UI,
no `configure` route, no permissions, no Drush, no plugins of its own.

- **Declare compiled assets in `THEME.theme_compiler.yml`; the YAML schema, where output lands, how to verify** →
  [configure/theme-compiler-yml.md](configure/theme-compiler-yml.md)
- **Services, compile triggers, the `AssetCompiler` API, hooks, storage/safety** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Depends on `compiler` (uses `plugin.manager.compiler`); needs a real compiler plugin
  installed (e.g. `compiler_scss` provides `scss`). Requires Drupal `^10.6 || ^11.3`, PHP `>=8.3`.
- No routes/controller (removed since 2.x). Compiled bytes land at
  `public://compiled-assets/<theme>/<target>` (path = container parameter
  `theme_compiler.asset_storage_path`) and are fetched at that file's normal public URL.
- Discovery + compile services: `theme_compiler.asset_discovery` (`AssetDiscovery`),
  `theme_compiler.compiler` (`AssetCompiler`, `@api`), `theme_compiler.compile_subscriber`.
- Recompiles on theme install/uninstall and on `THEME.settings` config save/rename/delete.
- Hooks: `hook_theme_compiler_TYPE_alter($compiler, $asset)` (alter the plugin pre-compile),
  `hook_theme_compiler_asset_updated($asset)` (after a successful compile).
