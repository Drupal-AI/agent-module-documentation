# Pager Serializer settings

Config object: **`pager_serializer.settings`** (has `config/install` defaults + schema).
Form route `pager_serializer.settings` → `/admin/config/pager_serializer`
(*Configuration → Web services → Pager Serializer*), permission **administer site
configuration**. A confirm form at route `pager_serializer.settings.reset`
(`/admin/config/pager_serializer/reset`) restores all defaults.

## Keys (with shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `rows_label` | `rows` | property name the serialized rows are returned under |
| `pager_object_enabled` | `true` | wrap pager in its own object; if false the pager fields are merged onto the top-level response |
| `pager_label` | `pager` | property name of the pager object (used only when `pager_object_enabled`) |
| `current_page_enabled` | `true` | include current page |
| `current_page_label` | `current_page` | its property name |
| `total_items_enabled` | `true` | include total item count |
| `total_items_label` | `total_items` | its property name |
| `total_pages_enabled` | `true` | include total page count |
| `total_pages_label` | `total_pages` | its property name |
| `items_per_page_enabled` | `true` | include items-per-page |
| `items_per_page_label` | `items_per_page` | its property name |

Label fields are `#required` in the form (must be non-empty).

## Output shape

`pager_object_enabled = true` (default):

```json
{ "rows": [ ... ], "pager": { "current_page": 0, "total_items": 42, "total_pages": 5, "items_per_page": 10 } }
```

`pager_object_enabled = false` (flattened):

```json
{ "current_page": 0, "total_items": 42, "total_pages": 5, "items_per_page": 10, "rows": [ ... ] }
```

## drush

```bash
drush cget pager_serializer.settings                       # all values
drush cget pager_serializer.settings current_page_label    # single value

drush cset pager_serializer.settings pager_label meta -y
drush cset pager_serializer.settings current_page_label page -y
drush cset pager_serializer.settings total_items_enabled 0 -y   # drop total_items
```

PHP:

```php
\Drupal::configFactory()->getEditable('pager_serializer.settings')
  ->set('pager_label', 'meta')->set('current_page_label', 'page')->save();
```

Reset to defaults: visit the reset route, or re-set each key to the defaults in the table above.
