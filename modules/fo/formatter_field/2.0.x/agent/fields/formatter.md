<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The formatter field type, widget & "Formatter from field" formatter

## Install & enable

```bash
drush en formatter_field -y
```

No Composer package of its own (the module ships no `composer.json`); it lives in the
`Field types` package and depends only on core **`field`** (`formatter_field.info.yml`).
No routes, no permissions, no services, no Drush, no config objects, no submodules.
Core requirement `^8 || ^9 || ^10 || ^11`.

## The four plugins

All under `src/Plugin/Field/`:

| Plugin | id | Class / file |
|---|---|---|
| Field type | `formatter_field_formatter_type` | `FieldType/FormatterItem.php` |
| Widget | `formatter_field_formatter_widget` | `FieldWidget/FormatterWidget.php` |
| Formatter (index) | `formatter_field_default_formatter` | `FieldFormatter/DefaultFormatter.php` |
| Formatter (target field) | `formatter_field_from` | `FieldFormatter/FromFieldFormatter.php` |

The field type declares `default_widget = formatter_field_formatter_widget` and
`default_formatter = formatter_field_default_formatter`, `category = "general"`,
and `serialized_property_names = { "settings" }`.

## What the field stores

`FormatterItem::propertyDefinitions()` / `schema()` define two columns:

- `type` — `varchar(64)`, the chosen formatter plugin id (or `''` for hidden).
- `settings` — `text/big`, a **PHP-`serialize()`d** array of that formatter's settings.

`isEmpty()` returns true when `type` is empty. There is exactly **one** field setting,
`field` (`defaultFieldSettings()` = `['field' => NULL]`), configured on the field-instance
settings form (`fieldSettingsForm()`): a required `select` listing every **configurable** field
(`FieldConfigInterface`) on the same bundle except the formatter field itself. This is the
"target" field whose display the editor will control.

Config schema (`config/schema/formatter_field.schema.yml`):
`field.field_settings.formatter_field_formatter_type` maps `field: string`; the stored value type
is `field.value.formatter_field_formatter_type: ignore` (the settings blob is opaque to schema).

## How the two formatters differ

- **`formatter_field_default_formatter` (label "Default")** is set on the formatter field's own
  display. `DefaultFormatter::viewElements()` just prints the raw choice for debugging: a `type`
  item (`#plain_text => $item->type`) and a `settings` item whose value is
  `var_export(unserialize($item->settings, ['allowed_classes' => FALSE]), TRUE)` as `#plain_text`.
  Both use `#plain_text`, so nothing is rendered as markup.

- **`formatter_field_from` (label "Formatter from field")** is set on the **target** field's
  display (not the formatter field's). It declares `field_types = {}` in its annotation and is
  attached to every other field type at runtime by
  `formatter_field_field_formatter_info_alter()` in `formatter_field.module`, which appends every
  field-type id (except `formatter_field_formatter_type`) to
  `$info['formatter_field_from']['field_types']`.

## How `formatter_field_from` renders (the core mechanism)

`FromFieldFormatter::getFormatter()`:

1. Looks over all field definitions on the entity's bundle and finds the formatter field whose
   `field` setting points back at **this** target field
   (`$definition->getType() == 'formatter_field_formatter_type' && $definition->getSetting('field') == $target_field_name`).
   If none is found it emits a warning message and renders nothing.
2. Reads that formatter field's stored value off the **entity**
   (`$items->getEntity()->get($formatter_field)`), taking `type` and
   `unserialize($settings, ['allowed_classes' => FALSE])`. If `type` is empty it renders nothing
   (the "- Hidden -" choice).
3. Builds a real formatter with `FormatterPluginManager::getInstance()` using the target field's
   definition, the stored `type` and `settings`, `view_mode => '_custom'`, and delegates:
   `prepareView()` → the real formatter's `prepareView()`, and `viewElements()` → its
   `viewElements()`. So the target field is rendered by an ordinary core/contrib formatter whose
   only unusual property is that its identity and settings came from a per-entity field value.

## The widget (choosing formatter + settings)

`FormatterWidget` (`multiple_values = TRUE`, `field_types = {formatter_field_formatter_type}`),
built via `ContainerFactoryPluginInterface` with the formatter plugin manager and entity field
manager. `formElement()`:

- Returns `[]` if the field's `field` setting is not configured yet, or adds a warning and returns
  `[]` if the named target field no longer exists.
- Wraps everything in a `details` container titled *"Display settings for <label> field"*.
- Builds the **Formatter** `select` from `FormatterPluginManager::getOptions($targetType)`, keeping
  only options whose plugin class passes `::isApplicable($target_definition)` and excluding
  `formatter_field_from` itself; prepends `'' => '- Hidden -'`. So an editor can only pick a
  formatter that core already considers valid for that field type.
- On selecting a formatter (AJAX callback `settingsFormAjax()` swapping the settings `div`), it
  instantiates that formatter and embeds its own `settingsForm()` — the editor edits the real
  formatter's settings.
- `massageFormValues()` stores `['type' => …, 'settings' => serialize($settings)]`.

## Wiring it up (site-builder steps)

1. Create the field to be dynamically displayed as usual (e.g. an image field).
2. Add a **Formatter Item** field to the same bundle; in its instance settings, set **Field to be
   formatted** to that target field.
3. On the bundle's **Manage display**, set the **target** field's format to
   **Formatter from field**.
4. On the entity edit form, the Formatter Item widget now lets the editor pick the formatter and
   its settings for that entity; the choice is stored on the entity, so it is revisioned and
   translatable like any field value.

## Notes

- The stored `settings` blob is opaque to config schema (`ignore` / `serialized_property_names`),
  so config-schema tooling will not validate it.
- Because the choice is a field value, whoever can edit that field on the entity controls the
  display; scope the formatter field to bundles that genuinely need per-entity display and rely on
  field access to constrain who edits it. This is an editorial-governance decision, not a defect.
- Both `unserialize()` sites pass `['allowed_classes' => FALSE]`, so the stored blob cannot
  instantiate arbitrary PHP objects.
