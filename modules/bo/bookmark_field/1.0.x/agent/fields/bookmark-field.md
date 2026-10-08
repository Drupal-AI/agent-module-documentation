<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bookmark` field type, widget and formatter

## Install / enable
`drush en bookmark_field`. Pulls in core `field` and `block` (both in core). No settings page, no
`config/install`. Add the field to a bundle: **Structure → Content types → Manage fields → Add
field → Bookmark** (a common machine name is `field_bookmark`, which is the default the service,
block, Twig function and token assume).

## Field type — `BookmarkFieldType`
`src/Plugin/Field/FieldType/BookmarkFieldType.php`, id **`bookmark`**, extends `FieldItemBase`.
Default widget & formatter both `bookmark_widget_type`.

- **One property**: `value`, a required `string` DataDefinition; `case_sensitive` setting is passed
  through to the property.
- **`defaultStorageSettings()`**: `max_length` = 255, `is_ascii` = FALSE, `case_sensitive` = FALSE.
- **`schema()`**: single column `value` — type `varchar_ascii` when `is_ascii` is TRUE else
  `varchar`, `length` = `max_length`, `binary` = `case_sensitive`.
- **`getConstraints()`**: adds a `ComplexData` → `Length` `max` = `max_length` constraint (message
  "%name: may not be longer than @max characters.").
- **`isEmpty()`**: empty when `value` is NULL or `''`.
- **`storageSettingsForm()`**: exposes only **Maximum length** (`number`, min 1, disabled once the
  field has data). `is_ascii` / `case_sensitive` have no form control — set them via config if
  needed.
- **`generateSampleValue()`**: a random word up to `max_length`.

This is essentially a plain single-value text field; its purpose is to hold the stable key that the
rest of the module resolves.

## Widget — `BookmarkWidgetType`
`src/Plugin/Field/FieldWidget/BookmarkWidgetType.php`, id **`bookmark_widget_type`**, `field_types
= { bookmark }`, injects `current_user`.

- Settings: `size` (60, required, min 1) and `placeholder` (''), shown by `settingsForm()` /
  summarised by `settingsSummary()`.
- `formElement()` renders one `textfield` (`#title` "Bookmark", `#maxlength` = the field's
  `max_length`, `#default_value` the current value, `#size`/`#placeholder` from settings).
- **Edit gate**: `'#access' => $this->currentUser->hasPermission('bookmark_field edit bookmark')`.
  See the permission caveat below — in practice this evaluates FALSE for all non-superusers.

## Formatter — `BookmarkFormatter`
`src/Plugin/Field/FieldFormatter/BookmarkFormatter.php`, id **`bookmark_widget_type`** (same id as
the widget), `field_types = { bookmark }`, extends `FormatterBase`. No settings.
`viewValue()` returns `nl2br(Html::escape($item->value))` — the raw value is HTML-escaped before
output, so a value containing markup is shown as text (no XSS).

## Config schema
`config/schema/bookmark_field.schema.yml` defines:
- `field.storage_settings.bookmark` → `max_length` (int), `is_ascii` (bool), `case_sensitive` (bool)
- `field.widget.settings.bookmark_widget_type` → `size` (int), `placeholder` (string)
- `block.settings.bookmark_block` → `entity_type`, `field_name`, `view_mode`, `bookmark` (strings)

## Permission caveat (important)
`bookmark_field.module` declares the intended edit permission with **`hook_permission()`**:

```php
function bookmark_field_permission() {
  return ['bookmark_field edit bookmark' => [...]];
}
```

`hook_permission()` was **removed in Drupal 8**; permissions must live in a
`*.permissions.yml` file, and this module ships none. Therefore the permission
`bookmark_field edit bookmark` is **never registered**: it does not appear on
`/admin/people/permissions`, and `hasPermission('bookmark_field edit bookmark')` returns FALSE for
every account except user 1 (who bypasses all permission checks). Consequence: the widget's
`#access` gate is effectively closed, so only user 1 can enter/edit a bookmark value through the
edit form (it fails closed, not open). To make the field editable for other roles you must add a
real `bookmark_field.permissions.yml` (or alter the widget). This is a functionality gap, not an
access bypass.
