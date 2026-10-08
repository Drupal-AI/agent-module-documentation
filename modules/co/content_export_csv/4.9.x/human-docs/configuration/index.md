# Configuration

Content Export CSV has no settings form to fill in — its only screen is the export
form itself, and its only setting is a permission. This page covers granting
access and using the form.

## Grant the export permission

The form is protected by a single, access-restricted permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant **Access content export** to
the roles that should be allowed to download content. Only trusted roles should
have it, since an export can pull a lot of content at once.

## Open the export form

Go to **Content → Content export** (`/admin/content/content-export`), or click the
**Export Content** action link on the content overview at `/admin/content`.

## The form, field by field

| Field | What it does |
|-------|--------------|
| **Content type** *(required)* | Choose the node type to export. Selecting a type triggers an AJAX refresh that reveals the field checkboxes below. |
| **Fields** | The list of exportable fields for the chosen type. Tick the ones you want as columns. **If you leave them all unticked, every valid field is exported.** |
| **Status** | Filter by publication status: **Published** (the default) or **Unpublished**. |
| **Include node URLs** | When ticked, appends each node's absolute URL as a trailing `url` column. Off by default. |
| **Strip tags** | When ticked (the **default**), removes HTML tags from field values so the CSV holds clean plain text. |
| **Export** | Submits the form and streams the CSV download. |

## What you get

On submit, the module writes a `content_export<timestamp>.csv` file (to the
private files directory if your site has one configured, otherwise the public
files directory), streams it to you as a download, then deletes the temporary
file. The first row is a header of the field names (plus `url` if you asked for
it), followed by one row per node.

A few details about how values are written:

- Every cell is wrapped in double quotes.
- **Multi-value fields** are flattened into a single cell, joined with the pipe
  character `|`.
- **Link fields** export their URL (`uri`); **entity-reference fields** export the
  referenced id (`target_id`).

## Exporting from code instead

Because the form streams a download and then stops, it's meant for interactive
use. If you need exports as part of a scheduled job or batch process, call the
`content_export_csv.export` service directly rather than the form — its methods
are documented in the [`agent/`](../agent/start.md) docs.
