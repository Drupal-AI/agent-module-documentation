# Field widgets (Manage Form Display)

Five field-widget plugins let an entity field render as a Selectify control. Set them on
`admin/structure/types/manage/<bundle>/form-display` (or any entity form display). All five extend the
abstract base `Plugin\Field\FieldWidget\SelectifyWidgetBase`, which itself extends core
`Drupal\Core\Field\Plugin\Field\FieldWidget\OptionsSelectWidget` — so they behave like the core
"Select list" widget plus Selectify classes/attributes/libraries. No new plugin *type* is defined;
these are ordinary `@FieldWidget` plugins.

## Widget plugins

| Plugin id (form-display) | Label | CSS class added | Extra libraries (on top of `selectify/selectify-base`, `selectify/selectify-helper`) |
|---|---|---|---|
| `selectify_dropdown` | Selectify Dropdown | `selectify-apply-dropdown` | `selectify/selectify-dropdowns`, `selectify/selectify-dropdown` |
| `selectify_dropdown_tags` | Selectify Dropdown Taggable | `selectify-apply-tags` | `selectify/selectify-dropdowns`, `selectify/selectify-dropdown-tags` |
| `selectify_dropdown_searchable` | Selectify Dropdown With Search | `selectify-apply-searchable` | `selectify/selectify-dropdowns`, `selectify/selectify-dropdown-searchable` |
| `selectify_dropdown_checkbox` | Selectify Dropdown With Checkbox | `selectify-apply-checkbox` | `selectify/selectify-dropdowns`, `selectify/selectify-dropdown-checkbox` |
| `selectify_dual` | Selectify Dual List | `selectify-apply-dual` | `selectify/selectify-dual` |

Note the **plugin ids differ from the integration "widget" values** used in `selectify.settings`
(Views/Form API/Webform), which are `selectify_dropdown`, `selectify_tags`, `selectify_searchable`,
`selectify_checkbox`, `selectify_dual`. Only the field-widget path uses the `_dropdown_*` ids.

## Applicable field types

Annotation `field_types` on every widget: `list_string`, `list_integer`, `list_float`,
`entity_reference`; `multiple_values = TRUE`.

`SelectifyWidgetBase::isApplicable()` adds a restriction: for `entity_reference` /
`entity_reference_revisions` fields it **hides the widget unless exactly one target bundle** is
configured (`handler_settings['target_bundles']` must be a single-element array). Multi-bundle or
all-bundle references produce optgroups, which Selectify does not support, so the widget is not offered.

## What `formElement()` does (`SelectifyWidgetBase.php:191`)

Builds on the parent select element and, unless `SelectifyHelper::isPageDisabled()` is true, sets:

- `#attributes['class'][]` = the widget's `selectify-apply-*` class; a unique `id`
  (`Html::getUniqueId(<prefix>-<field>-<delta>)`).
- `data-*` attributes read by the JS behaviors: `data-max-selections` (field cardinality; `-1` ⇒
  `'null'`), `data-field-name`, `data-multiple` (`'true'`/`'false'`), `data-placeholder` (widget
  setting `placeholder`), `data-drupal-selector`, `data-tracking="selectify-widget"`.
- ARIA: `aria-expanded="false"`, `aria-haspopup` (`listbox`, or `grid` for dual), `aria-describedby`,
  `aria-required`, `role` (`combobox`, or `listbox` for dual). `#multiple` mirrors the field's
  multiplicity; `required`/`form-required` set when the field is required.
- `#attached['library']` = base + helper + the per-widget libraries, plus the accent-color library
  `selectify/selectify-color-{accent}-{mode}` (admin vs front-end accent chosen via `AdminContext`),
  and `drupalSettings.selectify.maxSelections[<field>]`.
- Dual list only (`SelectifyDualWidget::alterElement()`) adds `selectify-single`/`selectify-multi` to
  the wrapper.

The select stays a real `<select>` (submitted normally); the JS overlay is what the user sees. The
`selectify_theme_suggestions_select_alter` + `selectify_theme` hooks route each `selectify-apply-*`
class to the matching `select--selectify-*.html.twig` template.

## Set a widget from code

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_tags', [
    'type' => 'selectify_dropdown_searchable',
    'settings' => ['placeholder' => 'Search tags…'],
  ])->save();
```

There is no dedicated widget-settings config schema beyond the inherited `OptionsSelectWidget`
settings; the only Selectify-specific setting consumed is `placeholder`.
