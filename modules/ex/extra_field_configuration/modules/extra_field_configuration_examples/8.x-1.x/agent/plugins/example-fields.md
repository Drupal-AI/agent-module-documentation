<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example extra field plugins

Enable with `drush en extra_field_configuration_examples -y`. Both plugins then appear in the
*Extra Field Provider* select on `/admin/structure/extra-field`; create an instance from either and
place it on an entity view display.

## `ExampleField` — simple

`src/Plugin/ExtraField/Display/ExampleField.php`.

- Annotation: `@ExtraFieldDisplay(id = "example_configurable_field", label = "Example Configurable
  Field", deriver = "Drupal\extra_field_configuration\Plugin\Derivative\ExtraFieldConfigurationDeriver")`.
- Extends `ExtraFieldDisplayBase`, implements `ContainerFactoryPluginInterface`, uses
  `StringTranslationTrait`; `create()` injects `string_translation`.
- `view(ContentEntityInterface $entity)` returns `['#markup' => $this->t('Example Configurable
  Extra Field')]` — a fixed translated string; the passed entity is not read.

Use this shape for an extra field that returns a plain render array with no field-template wrapper.

## `ExampleFormattedField` — formatted (with label)

`src/Plugin/ExtraField/Display/ExampleFormattedField.php`.

- Annotation: `id = "example_configurable_formatted_field"`, label *"Example Configurable Formatted
  Field"*, same deriver.
- Extends `ExtraFieldDisplayFormattedBase` (same DI pattern as above).
- `viewElements(ContentEntityInterface $entity)` returns `['#markup' => $this->t('Example
  Configurable Extra Formatted Field')]`.
- `getLabel()` returns `t('Extra Field Label')`; `getLabelDisplay()` returns `'above'` — so the
  output is wrapped in the standard field template with a label shown above.

Use this shape when the extra field should render like a normal field (label + wrapper). Override
`getLabel()` / `getLabelDisplay()` to control the label.

## Notes

Both plugins emit only static, translated markup and read no request, entity or remote data. They
are reference templates: copy the class, keep the `deriver` annotation line, and replace the body of
`view()` / `viewElements()` with your real render logic.

Parent plugin-type doc:
[../../../../../8.x-1.x/agent/plugins/configurable-extra-fields.md](../../../../../8.x-1.x/agent/plugins/configurable-extra-fields.md).
