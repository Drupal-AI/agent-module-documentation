<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure a Time Zone field

`tzfield` is a normal field type — add it via the Field UI or config. No module settings page
(`configure: null`). Stores one tz-database identifier per value (`value`, varchar(50),
indexed).

## Field type

`@FieldType(id = "tzfield", label = "Time zone", default_widget = "tzfield_default",
default_formatter = "basic_string")` — `TimeZoneItem`. Implements `OptionsProviderInterface`;
possible values = `\DateTimeZone::listIdentifiers()`. `isEmpty()` treats `NULL`/`''` as empty;
`generateSampleValue()` picks a random zone.

## Per-field settings (`field.field_settings.tzfield`)

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `exclude` | array of zone ids | `[]` | Zones removed from the allowed options. |
| `default_site` | bool | `FALSE` | Default a new value to `system.date` `timezone.default`. |
| `default_user` | bool | `FALSE` | Default a new value to the current user's time zone. Only offered when `system.date` `timezone.user.configurable` is TRUE; site default is the fallback. |

Applied in `TimeZoneItem::applyDefaultValue()`. The settings form is built by
`TimeZoneItem::fieldSettingsForm()`.

## Widgets

| Widget id | Label | Behavior |
|---|---|---|
| `tzfield_default` | Time zone | Select grouped by region (`TimeZoneFormHelper::getOptionsListByRegion()`, fallback `system_time_zones()`), minus `exclude`. |
| `tzfield_offset` | Time zone with current offset | Select sorted by current UTC offset, labelled e.g. `(UTC+01:00) Europe/London`; built by `TimeZoneWithOffsetWidget::getTimezonesList()`. |

Both render a single `#type => select` element; a non-required field gets a blank/"- None
selected -" option.

## Formatters

| Formatter id | Label | Notes |
|---|---|---|
| `basic_string` | (core) | Default. Prints the raw identifier. Enabled for `tzfield` via `tzfield_field_formatter_info_alter()` in `tzfield.module`. |
| `tzfield_date` | Formatted current date | Renders the **current** time in the stored zone using setting `format` (PHP date format string, default `T` → e.g. `GMT`). Rendered through a `#lazy_builder` placeholder calling `getRenderableFormattedDate()` (a trusted callback). |

`TimeZoneFieldFormatter::getRenderableFormattedDate()` builds a `DrupalDateTime`, calls
`setTimezone(new \DateTimeZone($value))`, and returns `['#markup' => $dateTime->format($format)]`;
a non-string `format` falls back to `T`.

## Via the UI

Add a Time Zone field, then set widget and formatter through the normal Field UI.

![Manage form display showing the tzfield widget on a content type](../../../../../../../screenshots/tzfield/1.14.x/manage-form-display.png)

1. *Structure → Content types → (type) → Manage fields → Add field → Time zone.*
2. On **field settings**, optionally pick zones under *"Time zones to be excluded from the
   option list"* and tick *Use site's default* / *Use current user's* time zone as default value.
3. On **Manage form display**, choose the `tzfield_default` or `tzfield_offset` widget.
4. On **Manage display**, choose `basic_string` (identifier) or `tzfield_date` (formatted
   current date; set its **Date format string**).

The region-grouped select then appears on the node add/edit form:

![Node add form showing the region-grouped time zone select widget](../../../../../../../screenshots/tzfield/1.14.x/node-form-widget.png)

## Scriptable (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_timezone', 'entity_type' => 'node', 'type' => 'tzfield',
])->save();
FieldConfig::create([
  'field_name' => 'field_timezone', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Time zone',
  'settings' => ['exclude' => ['Antarctica/Troll'], 'default_site' => TRUE, 'default_user' => FALSE],
])->save();
// widget:
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_timezone', ['type' => 'tzfield_offset', 'region' => 'content', 'weight' => 20])->save();
// formatter (formatted current date):
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_timezone', ['type' => 'tzfield_date', 'settings' => ['format' => 'T'], 'label' => 'inline'])->save();
```

Read back the storage type: `drush php:eval '$fs=\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_timezone"); print $fs->getType();'` → `tzfield`.

## Config schema

`config/schema/tzfield.schema.yml`: `field.field_settings.tzfield` (`exclude` sequence,
`default_site` bool, `default_user` bool) and `field.formatter.settings.tzfield_date` (`format`
string). Field value schema reuses `field.value.string`.

## Migration

A `migrate` field plugin id `tzfield` (`Plugin/migrate/field/TimeZoneField`, `core = {7}`)
maps Drupal 7 tzfield widgets/formatters (`options_select`/`tzfield_autocomplete` →
`tzfield_default`; `tzfield_default`/`tzfield_date` formatters) and copies the stored `value`.

## Install/update notes

`tzfield_update_8101` (in `tzfield.install`) adds an index to existing time zone fields.
`tzfield.post_update.php` defines an empty `tzfield_post_update_renamed_classes` whose only
effect is the post-update cache rebuild after the field plugin classes were renamed.
