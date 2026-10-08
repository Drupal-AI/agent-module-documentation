<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: services, triggers, hooks, storage

All classes are `@internal`; this describes how they fit together.

## Services (`theme_compiler.services.yml`)

| Service | Class | Role |
|---|---|---|
| `theme_compiler.compiler` | `Drupal\theme_compiler\Compiler` | Compiles route contexts and saves results to the sandbox. |
| `theme_compiler.controller` | `Controller\ThemeCompilerController` | Serves a compiled asset (`serve()`), 404/204 when missing. |
| `theme_compiler.route_helper` | `Routing\RouteHelper` | Builds the dynamic routes from each theme's YAML (`routes()`). |
| `theme_compiler.compile_subscriber` | `EventSubscriber\CompileSubscriber` | Recompiles on config/theme events. |

`Compiler` is constructed with the compiler plugin manager plus theme/file/cache services;
its sandbox constant is `Compiler::SANDBOX = 'public://theme-compiler-assets/'`.

## Compilation

`Compiler::compileAssets()` iterates `getThemeCompilerRouteContexts()` (all routes whose
`theme_compiler_context` default is a `RefineableCompilerContextInterface`) and, per context:

1. Reads its `theme_compiler` option (`theme`, `path`).
2. Calls `compile()` — `plugin.manager.compiler->createInstance($context->getCompiler())`,
   then lets modules alter via `hook_theme_compiler_alter` / `hook_theme_compiler_{ID}_alter`
   and every enabled theme alter via the same hook names, then `$plugin->compile($context)`.
   Any exception is wrapped in a `CompilerException`.
3. `compileAndSave()` resolves the target beneath the sandbox, `prepareDirectory()`, and
   `saveData()` (EXISTS_REPLACE), then invalidates cache tags `theme_compiler_asset:<hash>`
   and `library_info`.

`compileAssets()` is runtime-safe: per-context exceptions are logged and shown as a messenger
error, never fatal.

## What triggers (re)compilation

- **Theme install/uninstall** — `theme_compiler_themes_installed()` /
  `_themes_uninstalled()` rebuild the router then call `compileAssets()`.
- **Config save/delete** — `CompileSubscriber::onConfigChange()` fires on
  `ConfigEvents::SAVE` / `ConfigEvents::DELETE`; if the changed config matches
  `THEME.settings` for a theme that defines (or depends on a theme that defines) a compiler
  target, it recompiles.
- **On demand** — dispatching `OnDemandCompileEvent` runs `CompileSubscriber::compile()`.

`CompileSubscriber::getSubscribedEvents()` returns
`ConfigEvents::DELETE => onConfigChange`, `ConfigEvents::SAVE => onConfigChange`,
`OnDemandCompileEvent::class => compile`.

## Serving

`ThemeCompilerController::serve(CompilerContextInterface $ctx)`:

- Resolves the target beneath the sandbox (`normalizeAndResolveTargetPath`).
- Reads the file; 200 with the bytes (Content-Type `application/octet-stream`), 204 if empty,
  404 if unreadable.
- Adds cache tags `theme_compiler_asset` and `theme_compiler_asset:<hash>`, then lets
  modules/themes alter the response via
  `hook_theme_compiler_response_alter` / `hook_theme_compiler_response_{ID}_alter`.

## Hooks a theme/module can implement

- `hook_theme_compiler_alter(&$plugin, &$context)` — before compilation (all compilers).
- `hook_theme_compiler_TYPE_alter(&$plugin, &$context)` — before compilation for compiler `TYPE`.
- `hook_theme_compiler_response_alter(&$response)` / `_TYPE_alter` — alter the served response.

## Storage / safety

Compiled files live at `public://theme-compiler-assets/<theme>/<target-path>`. Target paths
are normalized and must resolve **beneath** the sandbox (`normalizeAndResolveTargetPath`
throws otherwise), preventing path-escape writes.
