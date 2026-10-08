# Configure Responsive Tables Filter

There are **two independent** things to configure: (1) the per-format **filter**, and
(2) an optional module **settings form** for Views/theme tables.

## 1. Enable the filter on a text format (the main use)

Admin UI: `admin/config/content/formats` → edit a format (e.g. Basic HTML, Full HTML) →
check **"Apply responsive behavior to HTML tables."** → pick the default mode / persist
option in the filter's settings → Save.

Config lives in the core `filter.format.<id>` config entity under
`filters.filter_responsive_tables_filter`.

### Enable + configure with drush (no UI)

```php
drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("basic_html");
  $fmt->setFilterConfig("filter_responsive_tables_filter", [
    "status"   => TRUE,
    "settings" => ["tablesaw_type" => "columntoggle", "tablesaw_persist" => TRUE],
  ]);
  $fmt->save();
'
drush cr
```

### Disable / remove it from a format

```php
drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("basic_html");
  $fmt->filters()->removeInstanceId("filter_responsive_tables_filter");
  $fmt->save();
'
```

(Or set `["status" => FALSE]` via `setFilterConfig` to keep it listed but off.)

### Read the current state

```php
drush php:eval '
  $f = \Drupal::config("filter.format.basic_html")->get("filters")["filter_responsive_tables_filter"] ?? NULL;
  echo $f ? json_encode($f) : "not configured";
'
# or the whole filters map:
drush cget filter.format.basic_html filters
```

A format that has never touched the filter simply has no
`filter_responsive_tables_filter` key in its stored `filters` map (and the plugin's
`status` defaults to `false`).

**Ordering / allowed-tags caveats:** place this filter *after* any "Limit allowed HTML tags"
or tag-stripping filter, and make sure that filter allows `<table> <thead> <tbody> <tfoot>
<tr> <th> <td>` and the `class` attribute — otherwise the added Tablesaw classes are stripped.

## 2. Module settings form — auto-apply to Views & theme tables

Route: `responsive_tables_filter.settings` at
`admin/config/content/responsive_tables_filter` (permission: *administer site
configuration*). Config object: `responsive_tables_filter.settings`.

| Key | Default | Meaning |
|---|---|---|
| `views_enabled` | `'0'` | When on, Tablesaw is auto-added to every Views-generated table and every table rendered via Drupal's `table` render element (`hook_preprocess_table` / `preprocess_views_view_table`). |
| `views_tablesaw_mode` | `stack` | Mode for those tables (`stack`, `columntoggle`, `swipe`). |

```php
drush cset responsive_tables_filter.settings views_enabled 1 -y
drush cset responsive_tables_filter.settings views_tablesaw_mode swipe -y
drush cr
```

This is separate from the per-format filter: it needs no text format and applies globally to
Views/theme tables. Leave `views_enabled` off for fine-grained, per-view control.
