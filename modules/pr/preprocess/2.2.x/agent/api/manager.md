<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dispatch & the manager services

## Services

| Service id | Class | Role |
|---|---|---|
| `preprocess.plugin.manager` | `PreprocessPluginManager` | The plugin manager: discovers `@Preprocess` + `*.preprocessors.yml` plugins, filters theme plugins by active theme, returns instances per hook |
| `preprocess.manager` | `PreprocessManager` | Orchestrates: for a hook, resolves suggestions and runs the plugins |

## How every theme hook gets processed

`preprocess.module`:

```php
function preprocess_preprocess(&$variables, $hook): void {
  $variables = \Drupal::service('preprocess.manager')->preprocess($hook, $variables);
}
```

`hook_preprocess()` fires for **all** theme hooks, so the manager sees every render. It also
implements `hook_theme_registry_alter()` to move `preprocess_preprocess` to the **end** of each
hook's `preprocess functions`, so plugin edits run after core/theme preprocessing.

`PreprocessManager::preprocess($hook, $variables)`:
1. computes theme-hook **suggestions** for the hook (`hook_theme_suggestions_HOOK` + alters);
2. runs the plugins registered for the base `$hook`;
3. then runs the plugins for each valid suggestion (e.g. `node__article`) present in the runtime
   theme registry.

`PreprocessManager::doPreprocess($hook, $variables)` just loops
`preprocess.plugin.manager->getPreprocessors($hook)` calling each plugin's `preprocess()`,
threading `$variables` through.

## Plugin manager API (useful for inspection)

```php
$m = \Drupal::service('preprocess.plugin.manager');
$m->getDefinitions();            // all registered plugin definitions (id => [id, hook, class, provider, ...])
$m->getPreprocessors('node');    // instantiated plugins whose hook === 'node' (active-theme filtered)
$m->hasPreprocessors();          // TRUE if any plugin is registered at all
```

`getPreprocessors($hook)` returns only the plugins whose definition `hook` equals `$hook`
(after theme-activity filtering), instantiated via `createInstance()`.

## Notes

- Definitions carry `provider` (the module or theme). `getDefinitions()` drops theme-provided
  definitions whose theme isn't the active theme (or a base theme of it).
- No config or state is stored — everything is discovery-based; `drush cr` (or
  `plugin.cache_clearer`) refreshes definitions after code changes.
