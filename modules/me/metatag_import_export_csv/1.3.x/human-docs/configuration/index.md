# Configuration

This module has no settings object of its own — its "configuration" is two batch
forms and two permissions that control who can use them. Both forms live under
**Configuration → Search and metadata → Metatag**.

## Permissions

Grant these to the appropriate roles at **People → Permissions**. Both are marked
as restricted (sensitive) permissions:

| Permission | Allows |
|------------|--------|
| `metatag import export csv download` | Access the export form and download meta tags as CSV. |
| `metatag import export csv upload` | Access the import form and update meta tags from a CSV — i.e. overwrite content. |

## Exporting meta tags

Go to **Configuration → Search and metadata → Metatag → Export/download**
(`/admin/config/search/metatag/download`). Choose:

- an **entity type** (node, user, taxonomy term, …),
- a **bundle**,
- the **meta tags** to include, and
- a **delimiter** (to match your spreadsheet's locale).

The module generates a CSV — one row per entity — and offers it as a download. The
columns are:

```
entity_id, entity_title, entity_bundle, entity_type, field_machine_name, alias, <tag1>, <tag2>, ...
```

Each tag column holds that tag's current value.

## Importing meta tags

Go to **Configuration → Search and metadata → Metatag → Import/upload**
(`/admin/config/search/metatag/upload`) and upload a CSV with a header row in the
same shape. The importer understands these columns:

| Column | Required? | Meaning |
|--------|-----------|---------|
| `entity_type` | Required unless `path_alias` is given | Entity type id, e.g. `node`. |
| `entity_id` | Required unless `path_alias` is given | The entity's id. |
| `path_alias` | Required if `entity_type`/`entity_id` are empty | A path alias (with leading `/`) used to look up the entity instead. |
| `field_machine_name` | **Always required** | The machine name of the entity's Metatag field to write to. |
| `language` | Optional | The langcode of the translation to update. |
| *(any other columns)* | — | Each is a **meta tag name**; the cell is the value to set. |

How each tag cell is treated:

- **Empty cell** → leave that tag's current value unchanged.
- **`_blank`** → explicitly clear that tag.
- A value that already matches what Metatag would generate is skipped (no change).

The import runs as a batch, reporting per‑row success and error messages. Rows that
lack a usable `field_machine_name` are reported as errors. A sample file ships with
the module at `sample/sample_file.csv` if you want a template to start from.
