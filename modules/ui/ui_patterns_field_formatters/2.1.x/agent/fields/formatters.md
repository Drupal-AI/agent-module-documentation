<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatters: pattern_all_formatter / pattern_each_formatter

Two field formatter plugins that render a field through a UI Patterns (1.x) component instead of a
custom field template. Both are configured per field on **Manage display** (or in Layout Builder);
there is no global settings page.

| Formatter id | Label | Class | When | Applicable to |
|---|---|---|---|---|
| `pattern_all_formatter` | Pattern (one for all) | `PatternOneForAllFormatter` | Renders **all** field items into **one** pattern instance | Any field type |
| `pattern_each_formatter` | Pattern (one for each) | `PatternOneForEachFormatter` (extends the above) | Renders **each** item into **its own** pattern instance | Multi-value fields only (`isApplicable()` requires cardinality > 1 or unlimited) |

Both are annotated with `field_types = {"string"}`, but
`ui_patterns_field_formatters_field_formatter_info_alter()` overwrites `field_types` for both to the
full list from `plugin.manager.field.field_type`, so they show up on every field. Both extend
`Drupal\field_formatter\Plugin\Field\FieldFormatter\FieldWrapperBase` (from the `field_formatter`
module), which is why the settings also carry a wrapped-formatter `type` + `settings` pair.

## Settings form

`settingsForm()` builds the standard field-wrapper form, removes the two pattern formatters from the
nestable `type` options (no self-nesting), shows an info message, then calls
`PatternDisplayFormTrait::buildPatternDisplayForm($form, 'field_properties', $context, $config)`
(trait from `ui_patterns`). `$context` = `['storageDefinition' => <field storage def>, 'limit' =>
<property names>]`. This renders the pattern picker, variant picker, and the per-destination mapping
table populated by the `field_properties`-tagged source plugins (see
[plugins/source-plugins.md](../plugins/source-plugins.md)). On submit, `cleanSettings()` /
`PatternDisplayFormTrait::processFormStateValues()` normalize the mapping.

## Config schema keys

From `config/schema/ui_patterns_field_formatters.schema.yml`. `pattern_all_formatter` extends
`field.formatter.settings.field_link`; `pattern_each_formatter` extends `pattern_all_formatter`.

| Key | Type | Meaning |
|---|---|---|
| `pattern` | string | Selected UI Patterns pattern (component) id |
| `pattern_variant` | string | Selected pattern variant machine name (optional) |
| `pattern_mapping` | sequence of mapping | Per pattern field: `weight` (int), `destination` (pattern field, or `_hidden`), `plugin` (source plugin id), `source` (source field id) |
| `pattern_settings` | sequence (ignore) | Extra pattern settings, keyed by pattern id (used by `ui_patterns_settings`) |
| `variants_token` | sequence (ignore) | Token-based variant selection, keyed by pattern id |
| (inherited) `type`, `settings` | — | The wrapped core/contrib formatter and its settings, from `FieldWrapperBase`, used for the `_formatted` source |

## What happens at runtime (`viewElements()`)

1. Returns `[]` if the item list is empty.
2. Walks `pattern_mapping`; skips rows whose `destination` is `_hidden`.
3. For `plugin === 'field_meta_properties'` rows, fills the destination from:
   `_label` → field label; `_field_display_label` → `field_display_label` third-party setting (if
   that module is on); `_entity_form_field_label` → `entity_form_field_label` setting (if on);
   `_formatted` → the wrapped formatter's rendered output via `getFieldOutput()`.
4. For `plugin === 'field_raw_properties'` rows, calls `extractValue($item, $source, $langcode)` per
   item. `extractValue()` handles `TextProcessed` (processed text), `EntityReference` (returns the
   referenced entity's translated label, or `NULL` if the target is gone), and `Uri` (builds the URL
   with `Url::fromUri()`, using link-item `options` for `field_item:link`); otherwise the raw value.
5. Builds a render element `['#type' => 'pattern', '#id' => <pattern>, '#fields' => $fields,
   '#multiple_sources' => TRUE]`, then attaches `#variant`, `#settings`, `#variant_token`, and a
   `#context` (`type` = `field_formatter`, plus `entity`/`items`/`item`, using the `$langcode`
   translation when translatable). `pattern_all_formatter` emits `$elements[0]` (all items);
   `pattern_each_formatter` emits one element per delta.

## Set it via PHP (on an entity view display)

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default');
$display->setComponent('field_tags', [
  'type' => 'pattern_each_formatter',
  'settings' => [
    'pattern' => 'card',
    'pattern_variant' => '',
    'pattern_mapping' => [
      'field_meta_properties:_label' => [
        'weight' => 0, 'destination' => 'title',
        'plugin' => 'field_meta_properties', 'source' => '_label',
      ],
      'field_raw_properties:value' => [
        'weight' => 1, 'destination' => 'body',
        'plugin' => 'field_raw_properties', 'source' => 'value',
      ],
    ],
    // Inherited FieldWrapperBase keys; needed for the `_formatted` source.
    'type' => 'string', 'settings' => [],
  ],
])->save();
```

## Upgrading

`hook_update_9201` migrates pre-2.x config: a single `pattern_formatter` becomes
`pattern_each_formatter` (multi-value) or `pattern_all_formatter` (single), and the legacy
`_label` / `_value_display` / other sources are rewritten onto `field_meta_properties` /
`field_raw_properties` mapping keys. `pattern_wrapper_entity_reference_formatter` folds into
`pattern_all_formatter` with an `entity_reference_entity_view` wrapped formatter.
