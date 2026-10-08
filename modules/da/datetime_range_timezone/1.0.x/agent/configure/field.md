<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure a Datetime Range Timezone field

No settings form (`configure: null`); configure per field via the field UI (or config). The
module provides one field type, one widget, and two formatters.

## Plugins

| Kind | id | Notes |
|---|---|---|
| Field type | `daterange_timezone` | extends core `DateRangeItem`; adds a `timezone` varchar(255) column. Default widget `daterange_timezone`, default formatter `daterange_timezone`. Storage still has a `datetime_type` (`date`/`datetime`) like core daterange. |
| Widget | `daterange_timezone` | extends core Date range widget; adds a **Timezone** select. Also accepts plain `daterange` fields. |
| Formatter | `daterange_timezone` | default; renders start–end via Twig. Settings: `separator` (default `-`), `format_type` (default `medium`), `display_timezone` (default TRUE). |
| Formatter | `daterange_timezone_single_date` | renders one endpoint. Settings: `date_field` (`start_date`\|`end_date`, default `start_date`), `format_type`, `display_timezone`. |

## Create a field (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_event_when',
  'entity_type' => 'node',
  'type' => 'daterange_timezone',
  'settings' => ['datetime_type' => 'datetime'],   // or 'date'
])->save();
FieldConfig::create([
  'field_name' => 'field_event_when',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Event when',
])->save();

// Widget (adds the Timezone select).
\Drupal::service('entity_display.repository')->getFormDisplay('node', 'article')
  ->setComponent('field_event_when', ['type' => 'daterange_timezone'])->save();

// Default formatter, hiding the timezone label and using a custom separator.
\Drupal::service('entity_display.repository')->getViewDisplay('node', 'article')
  ->setComponent('field_event_when', [
    'type' => 'daterange_timezone',
    'settings' => ['separator' => 'to', 'format_type' => 'long', 'display_timezone' => FALSE],
  ])->save();
```

## Single-date formatter

To show only the end date with its timezone:

```php
\Drupal::service('entity_display.repository')->getViewDisplay('node', 'article')
  ->setComponent('field_event_when', [
    'type' => 'daterange_timezone_single_date',
    'settings' => ['date_field' => 'end_date', 'format_type' => 'medium', 'display_timezone' => TRUE],
  ])->save();
```

## Read settings back

```bash
drush cget core.entity_view_display.node.article.default content.field_event_when
# -> type: daterange_timezone(_single_date), settings.display_timezone / separator / format_type / date_field
```

## Behavior notes

- The widget re-interprets the entered start/end in the selected timezone, then core stores
  them as UTC; the widget renders them back in the stored timezone on edit.
- Formatters use the stored `timezone` for all display, so a range reads correctly no matter
  the site/viewer timezone. `display_timezone` only controls whether the timezone **label** is
  appended.
