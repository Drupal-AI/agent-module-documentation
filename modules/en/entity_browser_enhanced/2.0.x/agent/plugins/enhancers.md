<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_browser_enhanced_plugin` plugin type

A **YAML-only** plugin type — no PHP class, no annotation/attribute. Discovery is
`YamlDiscovery('enhancers', <all module directories>)`, so definitions live in
`<module>/<module>.enhancers.yml` (wrapped in `ContainerDerivativeDiscoveryDecorator`, so
`deriver:` works too).

Manager: `plugin.manager.entity_browser_enhanced_plugin` →
`Drupal\entity_browser_enhanced\EntityBrowserEnhancedPluginManager`
(cache bin `cache.discovery`, cache key/tag `entity_browser_enhanced_plugin`).

## Definition shape

```yaml
# mymodule.enhancers.yml
my_enhancer:
  id: my_enhancer                     # required
  label: 'My Enhancer'                # required (translatable, label_context supported)
  form_extra_class: 'my-enhancer'     # required — extra CSS class put on the browser form
  library: 'mymodule/my_enhancer'     # required — a module OR theme library
```

All four keys are **required**: `processDefinition()` throws a `PluginException` if `id`,
`label`, `form_extra_class` or `library` is empty. Defaults are all `''`.

The module's own `entity_browser_enhanced.enhancers.yml` defines `multiselect` and `autoselect`.

## Reading definitions in code

```php
$defs = \Drupal::service('plugin.manager.entity_browser_enhanced_plugin')->getDefinitions();
// [ 'multiselect' => ['id'=>…, 'label'=>…, 'form_extra_class'=>'multiselect', 'library'=>…], … ]
```

The manager exposes convenience getters (`getId()`, `getLabel()`, `getFormExtraClass()`,
`getLibrary()`) but they read `$this->pluginDefinition`, which is **not set on the manager**
itself — read the array returned by `getDefinitions()` instead.

## Writing the JavaScript side

Your library is attached to the whole Entity Browser form, which will carry the classes
`entity-browser-enhanced` and your `form_extra_class`. Scope selectors accordingly:

```js
(function ($, Drupal, drupalSettings) {
  Drupal.behaviors.myEnhancer = {
    attach(context) {
      const cardinality =
        drupalSettings.entity_browser_enhanced?.my_enhancer?.cardinality ?? -1;
      $('form.entity-browser-enhanced.my-enhancer .views-col', context)
        .on('click', function () { /* toggle .selected, check input[name^="entity_browser_select"] */ });
    },
  };
})(jQuery, Drupal, drupalSettings);
```

Useful contract details taken from the bundled enhancers:

- Selection checkboxes are `input[name^="entity_browser_select"]`.
- The browser submit button carries `.is-entity-browser-submit`.
- View rows in a grid style are `.views-col`; the select column is
  `.views-field-entity-browser-select`.
- Entity Browser's selection list responds to the jQuery event
  `.entities-list` → `trigger('add-entities', [[entityId]])`.
- `drupalSettings.entity_browser_enhanced.<your_id>.cardinality` is only present when the
  browser is embedded as a field widget with a cardinality validator; `-1` means unlimited.
- `drupalSettings.entity_browser_widget.auto_select` comes from Entity Browser's View widget
  ("Automatically submit selection") and is what `autoselect` keys off.

After adding a new `*.enhancers.yml`, run `drush cr` — definitions are cached in `cache.discovery`.

## Registering it for a browser

Enhancers are not enabled globally; the id must be written into
`entity_browser_enhanced.widgets.<browser_id>` against a **View** widget's UUID —
see [../configure/assign-enhancer.md](../configure/assign-enhancer.md).
