<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON field types and how to create one

## The three field types

| id | Label | Column on MySQL | MariaDB | PostgreSQL | SQLite |
|---|---|---|---|---|---|
| `json` | JSON (text) | `varchar`/`text` sized by the `size` setting | same | same | same |
| `json_native` | JSON (raw) | `json` | `LONGTEXT` | `json` | `text` |
| `json_native_binary` | JSONB/JSON (raw) | `json` | `LONGTEXT` | `jsonb` | `text` |

All three: one property `value` (string), `category: json_data`,
`default_widget = json_textarea`, `default_formatter = json`,
`constraints = {"valid_json" = {}}`. `isEmpty()` is TRUE only for `NULL` or `''`
(so `"0"`, `{}` and `[]` all count as non-empty).

`json_native_binary` extends `json_native`; the only difference is the schema
(`pgsql_type: jsonb`).

## Storage setting — `size` (only on `json`)

`JsonItem::defaultStorageSettings()` is `['size' => 4294967296]`. The select on the field
storage form maps to:

| value | column |
|---|---|
| `255` | `varchar(255)` |
| `65535` | `text` size `normal` |
| `16777216` | `text` size `medium` |
| `4294967296` | `text` size `big` (default) |

A `Length` constraint is derived from it: max = `size` for 255, otherwise `floor(size / 4)`
(utf8mb4 costs 4 bytes/char). `json_native` / `json_native_binary` have **no** storage
settings.

## Create a JSON field with Drush

```php
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  FieldStorageConfig::create([
    "field_name" => "field_payload", "entity_type" => "node",
    "type" => "json",                       // or json_native / json_native_binary
    "settings" => ["size" => 65535],        // json only
  ])->save();
  FieldConfig::create([
    "field_name" => "field_payload", "entity_type" => "node",
    "bundle" => "article", "label" => "Payload",
  ])->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_payload", ["type" => "json_textarea", "weight" => 30, "region" => "content"])->save();
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_payload", ["type" => "json", "label" => "above", "weight" => 30, "region" => "content"])->save();
'
```

Read it back:

```bash
drush cget field.storage.node.field_payload type       # json
drush cget field.storage.node.field_payload settings   # size: 65535
drush cget core.entity_view_display.node.article.default content.field_payload
```

## In the UI

*Structure → Content types → … → Manage fields → Create a new field*, category
**JSON data**, then pick JSON (text) / JSON (raw) / JSONB (raw). There is **no** module
settings page — `configure` is `null` in `json_field.info.yml`.

## Writing values

The value is always the raw JSON **string**, not a PHP array:

```php
$node->set('field_payload', json_encode(['sku' => 'ABC', 'qty' => 2]))->save();
$data = json_decode($node->get('field_payload')->value, TRUE);
```

Invalid JSON is rejected by the `valid_json` constraint on validation
(`$node->validate()`, entity forms, REST/JSON:API writes) — but **not** by a direct
`->save()`, which bypasses validation.

## Database requirements

`json_field_requirements()` (service `json_field.requirements`) warns on the status report
when the DB is older than MySQL 5.7.8 / MariaDB 10.2.7 / PostgreSQL 9.2 / SQLite 3.26, and
when `/libraries/jquery-jsonview/dist/jquery.jsonview.{js,css}` are missing. Both are
warnings, never blockers.
