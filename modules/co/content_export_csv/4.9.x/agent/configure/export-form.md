<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Content Export form

There is **no settings/config page** — the module's only UI is the export form itself.

- Route: `content_export_csv.export`
- Path: **/admin/content/content-export**
- Also reachable via the "Export Content" action link on `/admin/content`
  (`system.admin_content`) and a "Content export" menu link under Content.
- Permission: **`access content export`** (`restrict access: true`).
- Form class: `Drupal\content_export_csv\Form\ContentExportForm` (`getFormId()` =
  `content_export_csv_form`).

> Note: `info.yml`'s `configure: content_export_csv.data-export` references a non-existent
> route. Use `content_export_csv.export`.

## Form fields

| Field | Type | Notes |
|---|---|---|
| `content_type` | select (required) | Options = all node types (`getContentTypes()`). Has an AJAX callback that reveals the field checkboxes for the chosen type. |
| `fields` | checkboxes | Appears after a type is chosen; options = `getValidFieldList($type)`. If none checked, **all** valid fields are exported. |
| `status` | select | `1` = Published (default), `0` = Unpublished. |
| `include_node_urls` | checkbox | Append each node's absolute URL as a trailing `url` column. Default off. |
| `strip_tags` | checkbox | Strip HTML tags from field values. Default **on**. |
| `export` | submit | Streams the CSV download. |

## What submit does

Writes `content_export<timestamp>.csv` to the **private** files dir if one is configured,
otherwise the **public** files dir, writes a header row of field names (plus `url` if
requested) then one line per node, streams it as a `text/csv` attachment download, and
`unlink()`s the temp file. Values are wrapped in double quotes; multi-value fields are joined
with `|`; link fields export their `uri`, entity-reference fields their `target_id`.

Because it `exit`s after `readfile()`, the form is meant for interactive download; for
scripted/batch use call the service directly (see api/export-service.md).
