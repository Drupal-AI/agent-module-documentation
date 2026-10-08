<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big Data Table — config entity & schema

## Entity type

`big_datatable` is a **config entity** (`src/Entity/BigDataTable.php`,
`Drupal\Core\Config\Entity\ConfigEntityBase`), not content. `config_prefix = big_datatable`,
`admin_permission = administer big_datatable`, `entity_keys` id=`id`, label=`name`.
Interface `BigDataTableInterface` (`src/BigDataTableInterface.php`) is an empty extension of
`ConfigEntityInterface`. Handlers: `list_builder` = `BigTableListBuilder`; forms `add`/`edit` =
`BigDataTableForm`, `delete` = core `EntityDeleteForm`.

## Exported config keys (`config_export`)

- `id` — machine name (also the HTML filename `<id>.html`).
- `name` — human label (`entity_keys.label`).
- `title` — page heading rendered in `view()`.
- `body` — a `text_format` value (`{value, format}`); getter `getBody()`.
- `bigdata_file` — the managed **file id (fid)** of the uploaded CSV; getter `getBigdataFile()`,
  setter `setBigdataFile($v)` stores `$v[0]`.
- `url` — listed in `config_export` but has **no matching class property**; effectively unused
  (the friendly URL is stored as a `path_alias`, not on the entity).

Getters/setters: `getTitle()/setTitle()`, `getBody()/setBody()`, `getBigdataFile()/setBigdataFile()`.
`jsonSerialize()` (from `\JsonSerializable`) returns `id`, `name`, `title`,
`check_markup(body.value, body.format)`, and `bigdata_file` — but no route or service serializes the
entity, so it is currently dormant.

## Schema (`config/schema/big_datatable.schema.yml`)

Type `config_entity` on `big_datatable.big_datatable.*`:

- `name` → `label`
- `id` → `string`
- `title` → `label`
- `body` → `text_format`
- `bigdata_file` → `integer` ("fid of CSV File")
- `header` → `sequence` ("Header list") — declared in schema but not in `config_export`.

## Example config (`big_datatable.big_datatable.people.yml`)

```yaml
id: people
name: 'People directory'
title: 'Company people'
body:
  value: '<p>All current staff.</p>'
  format: basic_html
bigdata_file: 42
```

The generated markup for this entity lives outside config, in the public file
`public://big_data_tables/people.html`, and is (re)built by "Generate HTML" or
`drush bigdata-generate-html` — see [../api/entity-and-generation.md](../api/entity-and-generation.md).
