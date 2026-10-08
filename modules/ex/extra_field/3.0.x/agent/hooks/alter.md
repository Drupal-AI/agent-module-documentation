<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks (`extra_field.api.php`)

Two hooks, both receiving the raw definition array collected by plugin discovery, keyed by
plugin id. Declared alter names are `extra_field_display_info` and `extra_field_form_info`
(set with `alterInfo()` in each manager).

```php
/**
 * Implements hook_extra_field_display_info_alter().
 */
function my_module_extra_field_display_info_alter(array &$info) {
  // Let a plugin that was written for nodes also run on every taxonomy term.
  if (isset($info['all_nodes'])) {
    $info['all_nodes']['bundles'][] = 'taxonomy_term.*';
  }
}

/**
 * Implements hook_extra_field_form_info_alter().
 */
function my_module_extra_field_form_info_alter(array &$info) {
  if (isset($info['example_markup'])) {
    $info['example_markup']['visible'] = FALSE;   // stop it appearing by default
    $info['example_markup']['weight'] = 200;
  }
}
```

Alterable keys are the definition keys: `id`, `label`, `description`, `bundles`, `weight`,
`visible` (plus `class`, `provider` added by discovery).

Notes:

* The hooks run inside plugin **discovery**, so changes are cached — run `drush cr` after
  editing them.
* Removing an entry (`unset($info['x'])`) removes the pseudo-field entirely; any display
  component named `extra_field_x` then just disappears from the render/form.
* `bundles` values you add follow the same wildcard rules as in the plugin definition
  (`entity_type.bundle`, `entity_type.*`, `*.*`).
* These are the module's only hooks. Extra Field itself implements
  `hook_entity_extra_field_info()`, `hook_entity_view()`, `hook_form_alter()` and
  `hook_entity_bundle_create()` — you do not need to.
