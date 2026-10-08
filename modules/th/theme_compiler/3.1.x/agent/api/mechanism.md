<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: services, triggers, hooks, storage

`Asset`, `AssetDiscovery` and `CompileSubscriber` are internal plumbing; `AssetCompiler` is the
one `@api` service.

## Services (`theme_compiler.services.yml`)

| Service | Class | Role |
|---|---|---|
| `theme_compiler.asset_discovery` | `Drupal\theme_compiler\AssetDiscovery` | Finds & validates `THEME.theme_compiler.yml` entries, returns cached `Asset` list. |
| `theme_compiler.compiler` | `Drupal\theme_compiler\AssetCompiler` (`@api`) | Compiles each asset and writes the result to disk. |
| `theme_compiler.compile_subscriber` | `EventSubscriber\CompileSubscriber` | Recompiles on relevant `THEME.settings` config events. |

Container parameter `theme_compiler.asset_storage_path` = `public://compiled-assets` sets where
output is written; it is injected into `AssetDiscovery` (trailing slashes trimmed).

## Discovery (`AssetDiscovery`)

`YamlDiscovery('theme_compiler', $theme_handler->getThemeDirectories())` reads
`THEME.theme_compiler.yml` from every theme. `getDefinitions()` returns a list of `Asset`
objects, cached in `cache.default` under `theme_compiler_assets` (tag `theme_compiler_assets`).
Each entry is validated (see [configure/theme-compiler-yml.md](../configure/theme-compiler-yml.md)):
safe relative target key, `plugin` is a registered compiler id, `source` is a non-empty list of
existing files. An `Asset` is `{ id: sha384("<theme>/<target>"), provider: <theme>, target:
"<storage>/<theme>/<target>", plugin, source[] }` (all `readonly`).

## Compilation (`AssetCompiler`)

`compileAssets()` iterates `AssetDiscovery::getDefinitions()` and per asset calls
`compileAndSave()`:

1. `compile($asset)` — `plugin.manager.compiler->createInstance($asset->plugin)`, wrap each
   source path in a `CompilerInputFile`, invoke `hook_theme_compiler_{plugin}_alter` (module +
   theme, see below), then `$plugin->compile(...$inputs)` and return the bytes.
2. `prepareDirectory(dirname(target), CREATE_DIRECTORY | MODIFY_PERMISSIONS)`, then
   `saveData($compiled, $asset->target, FileExists::Replace)`.
3. Invoke `hook_theme_compiler_asset_updated($asset)`.

`compileAssets()` is runtime-safe: a per-asset `\Throwable` is logged via `Error::logException`
and shown once as a generic messenger error — never fatal.

## What triggers (re)compilation

- **Theme install/uninstall** — `theme_compiler_themes_installed()` /
  `theme_compiler_themes_uninstalled()` (in `theme_compiler.module`) call
  `theme_compiler.compiler->compileAssets()`.
- **Config save / rename / delete** — `CompileSubscriber::onConfigChange()` fires on
  `ConfigEvents::SAVE`, `RENAME`, and `DELETE`; if the changed config name matches
  `<theme>.settings` for a theme that defines an asset (or is a sub-theme of one — see
  `getConfigDependencies()`), it recompiles all assets.

There is **no `OnDemandCompileEvent`** anymore (removed since 2.x). To force a recompile from
code, call `\Drupal::service('theme_compiler.compiler')->compileAssets()`.

## Hooks a theme/module can implement (`theme_compiler.api.php`)

- `hook_theme_compiler_TYPE_alter(CompilerPluginInterface $compiler, Asset $asset)` — invoked
  **before** compilation for compiler `TYPE` (e.g. `hook_theme_compiler_scss_alter`). Mutate the
  compiler with its own public methods (e.g. `setOutputStyle()`, `setVariable()`); do **not**
  replace the argument or modify the asset. Invoked for every module, then the providing theme
  and each of its base themes.
- `hook_theme_compiler_asset_updated(Asset $asset)` — invoked **after** the asset is compiled and
  saved; use to copy/post-process `$asset->target`.

Both are dispatched by `AssetCompiler::invokeHookForAsset()`: `moduleHandler->invokeAll()` first,
then `themeManager->invoke()` for the provider's base themes (reversed) and the provider itself.
The generic `hook_theme_compiler_alter` and the response-alter hooks from 2.x are **gone** (there
is no served-response step to alter now).

## Storage / safety

Compiled files live at `public://compiled-assets/<theme>/<target>` (or wherever
`theme_compiler.asset_storage_path` points). Target keys are validated at discovery to reject
`.`/`..` segments and non-safe characters, so a definition cannot direct writes outside the
per-theme storage directory. Output is a public static file served directly by the web server.
