<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `config_override_warn.form_overrides` service + detection mechanism

Service id: `config_override_warn.form_overrides`
Class: `Drupal\config_override_warn\FormOverrides`
Arguments: `@config.factory`, `@config.typed`

## Public methods

| Method | Returns |
|---|---|
| `getFormOverrides(FormInterface $form)` | Nested array `[config_name][key] => ['original' => …, 'override' => …]` (or `NULL` per key when `show_values` is off). Merges the results for every config name the form edits. |
| `getFormConfigNames(FormInterface $form)` | The config names a form edits (see below). |
| `getConfigOverrideDiffs(string $name)` | Same nested shape, for one config object. **The most useful entry point for scripts.** |
| `getConfigOverrides(Config $config)` | The raw merged override array read out of the `Config` object. |

## How the config names of a form are resolved

```php
// FormOverrides::getFormConfigNames()
if ($form instanceof EntityForm) {
  // only for a ConfigEntityInterface that is NOT new
  $names = [$form->getEntity()->getConfigDependencyName()];   // e.g. views.view.frontpage
}
elseif (method_exists($form, 'getEditableConfigNames')) {
  // ConfigFormBaseTrait::getEditableConfigNames() is protected — called via ReflectionMethod
  $names = $method->invoke($form);
}
```

Consequences worth knowing:

- A plain `FormBase` with no `getEditableConfigNames()` is never inspected.
- A config-entity **add** form (`isNew()`) is skipped.
- Content entity forms are skipped.

## How overridden keys are found

`Config::hasOverrides()` gates the work. The overridden keys themselves are not public API, so
the service uses `\ReflectionProperty` on the `Config` object's protected `moduleOverrides` and
`settingsOverrides` and deep-merges them. The key list is then flattened against the typed-config
definition: a nested array is only recursed into when the schema declares that key as
`type: mapping`, otherwise the whole array is reported as one key.

Per key: `original = $config->getOriginal($key, FALSE)` (stored value, overrides excluded) versus
`override = $config->get($key)` (effective value). Identical values are dropped. When both sides
are arrays they are reduced with `DiffArray::diffAssocRecursive()` in both directions so only the
differing members remain.

## Calling it

```bash
drush php:eval '
  $d = \Drupal::service("config_override_warn.form_overrides")->getConfigOverrideDiffs("system.site");
  print json_encode($d) . "\n";'
# {"system.site":{"slogan":{"original":"''","override":"'Pinned by deployment'"}}}
```

Note the values are already `var_export()`ed **strings**, not raw values.

## Rendering

`hook_form_alter()` builds `['#theme' => 'config_override_warn_overrides', '#overrides' => $overrides]`,
renders it with `renderInIsolation()` and calls `messenger()->addWarning()`. The theme hook
`config_override_warn_overrides` (one variable, `overrides`) is registered in
`config_override_warn_theme()`; override
`templates/config-override-warn-overrides.html.twig` in a theme to change the wording.

## Creating an override the module will report

```php
// mymodule.services.yml
// services:
//   mymodule.overrider:
//     class: Drupal\mymodule\MyOverrides
//     tags:
//       - { name: config.factory.override, priority: 5 }

class MyOverrides implements \Drupal\Core\Config\ConfigFactoryOverrideInterface {
  public function loadOverrides($names) {
    return in_array('system.site', $names) ? ['system.site' => ['slogan' => 'Overridden']] : [];
  }
  public function getCacheSuffix() { return 'mymodule'; }
  public function getCacheableMetadata($name) { return new \Drupal\Core\Cache\CacheableMetadata(); }
  public function createConfigObject($name, $collection = \Drupal\Core\Config\StorageInterface::DEFAULT_COLLECTION) { return NULL; }
}
```

After enabling that module, `\Drupal::config('system.site')->hasOverrides()` is `TRUE` and the
Basic site settings form (`system.site_information_settings`) shows the warning.
