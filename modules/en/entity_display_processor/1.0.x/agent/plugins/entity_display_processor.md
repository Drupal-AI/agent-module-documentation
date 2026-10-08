<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Entity display processor" plugin type

Everything for defining, discovering, and running a processor plugin. Cited files are under
`src/` of the module.

## Interface — what a plugin must implement

`Plugin/EntityDisplayProcessorInterface`:

```php
public function process(array $element, EntityInterface $entity): array;
```

`$element` is the entity's build render array; return the modified array. That is the entire
contract. A plugin may additionally implement core `PluginFormInterface` to expose settings in the
UI (the bundled plugin does).

## Attribute — how a plugin is declared

`Attribute/EntityDisplayProcessor` extends `Drupal\Component\Plugin\Attribute\Plugin`
(`#[\Attribute(\Attribute::TARGET_CLASS)]`). Params: `string $id`,
`?TranslatableMarkup $label = NULL`, `?string $deriver = NULL`.

## Manager — discovery & instantiation

`EntityDisplayProcessorManager` (namespace `Drupal\entity_display_processor`) extends
`DefaultPluginManager`. Registered in `entity_display_processor.services.yml` with
`_defaults: { autowire: true }`.

- Subdirectory `Plugin/EntityDisplayProcessor`; interface
  `EntityDisplayProcessorInterface::class`; attribute `EntityDisplayProcessor::class`.
- `alterInfo('entity_display_processor')` → alter hook `hook_entity_display_processor_alter()`.
- `setCacheBackend(cache.discovery, 'entity_display_processor_info')`.
- `createInstance($plugin_id, $configuration = [])` — throws `PluginException` on empty/non-string
  id, `PluginNotFoundException` if nothing is built, `InvalidPluginDefinitionException` if the
  instance is not an `EntityDisplayProcessorInterface`. Return type is narrowed to the interface.
- `getInstance(array $options)` — convenience: `createInstance($options['id'] ?? NULL,
  $options['settings'] ?? [])`. This is what the view-alter hook calls with the stored
  `{id, settings}`.

## Running on render

`Hook/EntityView::entityViewAlter()` (`#[Hook('entity_view_alter')]`) reads
`$display->getThirdPartySetting('entity_display_processor', 'processor')`; if empty it returns.
Otherwise it calls `$this->entityDisplayProcessorManager->getInstance($conf)` (catching
`PluginException` and bailing out with a `@todo` note) and assigns
`$build = $processor->process($build, $entity)`. Only **one** processor per view display is applied.

## Bundled plugin — `custom_classes`

`Plugin/EntityDisplayProcessor/AddCustomClasses` (label *"Add custom classes"*) extends
`PluginBase`, implements `EntityDisplayProcessorInterface` + `PluginFormInterface`.

- `process()`: `explode(' ', $this->configuration['classes'] ?? '')` and pushes each onto
  `$element['#attributes']['class'][]`.
- `buildConfigurationForm()`: one `textfield` `classes` with `#pattern` = `CLASSES_PATTERN`
  (regex `[a-zA-Z_][a-zA-Z0-9_\-]*( [a-zA-Z_][a-zA-Z0-9_\-]*)*` — one or more space-separated CSS
  identifiers, no leading/trailing/double spaces). `validateConfigurationForm()` and
  `submitConfigurationForm()` are empty (the settings array is captured by the display form's
  submit handler).

## Writing your own plugin

1. In `your_module/src/Plugin/EntityDisplayProcessor/Foo.php`, add
   `#[EntityDisplayProcessor('foo', new TranslatableMarkup('Foo'))]` on a class implementing
   `EntityDisplayProcessorInterface` (extend `PluginBase`; add `PluginFormInterface` for settings).
2. Implement `process()` to mutate and return the build (add wrappers, classes, `#prefix`/`#suffix`,
   `#cache`, read `$entity` field values, etc.).
3. Clear caches; the plugin appears in the *Manage display* selector (see
   [../config/display.md](../config/display.md)).
