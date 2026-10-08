# Import / Export metatags as CSV

No settings page — two batch forms under *Configuration > Search and metadata > Metatag*.

## Forms, routes, permissions

| Action | Route | Path | Permission |
|---|---|---|---|
| Export (download) | `metatag_import_export_csv.download` | `/admin/config/search/metatag/download` | `metatag import export csv download` |
| Import (upload) | `metatag_import_export_csv.upload` | `/admin/config/search/metatag/upload` | `metatag import export csv upload` |

Both permissions are `restrict access: TRUE`. The module's `configure` route is the Export
form. It has **no config object of its own**.

## Export

Pick an **entity type** (node, user, taxonomy_term, …), a **bundle**, the **meta tags** to
include, and a **delimiter**; a CSV is generated (batch) and offered as a download. Columns:

```
entity_id, entity_title, entity_bundle, entity_type, field_machine_name, alias, <tag1>, <tag2>, ...
```

(One row per entity; each tag column holds the tag's `content`/`href` value.)

## Import CSV format

Upload a CSV with a header row. Columns the importer understands:

| Column | Required? | Meaning |
|---|---|---|
| `entity_type` | Required unless `path_alias` is given | Entity type id (e.g. `node`). |
| `entity_id` | Required unless `path_alias` is given | Entity id. |
| `path_alias` | Required if `entity_type`/`entity_id` are empty | Path alias incl. leading `/`; resolved to an entity. |
| `field_machine_name` | **Mandatory** | Machine name of the entity's **Metatag field** to write to. |
| `language` | Optional | Langcode of the translation to update. |
| *(other columns)* | — | Each is a **meta tag name**; the cell is the value to set. |

Value rules per tag cell:

- **Empty cell** → leave that tag's current value unchanged.
- **`_blank`** → explicitly set the tag to empty.
- A value **equal to what Metatag would already generate** is skipped (no-op).

The importer loads each entity (optionally its `language` translation), encodes the changed
tags (`metatag_data_encode()` on v2, or `serialize()` on v1), sets the Metatag field, and
saves — running as a Batch API process with per-row success/error messages. Rows missing a
usable `field_machine_name` are reported as errors.

A sample file ships at `sample/sample_file.csv` in the module.
