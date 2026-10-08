# Configuration

There is nothing to configure globally — the module is two admin forms, both gated
by the **Administer CSV Term Import** permission. This page walks through using
them.

## Import — paste CSV to create terms

Go to **Configuration → Content authoring → Term CSV Import**
(`/admin/config/content/term-csv-import`). It's a three-step form:

1. **Paste your CSV** into the *Input* box and choose a **Taxonomy** — either an
   existing vocabulary or *Create new*. Optionally tick:
   - **Preserve Vocabularies on existing terms** — when a matching term already
     exists in a different vocabulary, keep it where it is instead of moving it.
   - **Preserve existing terms** — if a term already exists (by ID, or by name +
     parent), **skip** it rather than modifying it. This prevents ID clashes when
     importing from another install.
2. **(Only if creating a new vocabulary)** enter its name and machine name.
3. **Confirm** the reported term count and click **Import**.

### The CSV format

A header row is optional — the importer detects the columns by counting them. Two
column sets are supported:

Without IDs (6 columns, plus an optional 7th `fields` column):

```
name,status,description__value,description__format,weight,parent_name
```

With IDs (10 columns, plus an optional 11th `fields` column):

```
tid,uuid,name,status,revision_id,description__value,description__format,weight,parent_name,parent_tid
```

Column notes:

- **status** — `1` for published, `0` for unpublished.
- **parent_name / parent_tid** — the term's parent(s). **Multiple parents are
  separated by a semicolon** (for example `Europe;EU`). Leave empty for a
  top-level term.
- **description__format** — the text format machine name for the description (for
  example `basic_html`).
- **weight** — sets the ordering of terms.
- **fields** (optional trailing column) — any extra taxonomy fields, encoded as a
  URL query string (for example `field_color=red&field_code=EU`). Those fields
  must already exist on the vocabulary, or you'll see a warning.
- Values are read with standard CSV parsing, so quote any value that itself
  contains a comma.

Example (no IDs, with header):

```
name,status,description__value,description__format,weight,parent_name
Europe,1,,basic_html,0,
France,1,The country,basic_html,0,Europe
Paris,1,,basic_html,0,France
```

> Large imports run in a single request (there is no batch process), so very big
> files may hit PHP time/memory limits — split them if needed.

## Export — copy a vocabulary to CSV

Go to **Configuration → Content authoring → Term CSV Export**
(`/admin/config/content/term-csv-export`). It's a two-step form: pick a
**Taxonomy** and your options, submit, then copy the CSV from the *CSV Data*
textarea. The options are:

- **Include Term Ids in export** — adds the `tid`, `uuid`, `revision_id` and
  `parent_tid` columns. Include these if you want to preserve IDs on re-import.
- **Include Term Headers in export** — prepends the header row.
- **Include extra fields in export** — appends the encoded `fields` column with any
  extra taxonomy fields.

The export walks the whole vocabulary tree and emits one row per term, building the
`parent_name` / `parent_tid` values from each term's parents.

## Typical round-trip

Export a vocabulary with **IDs** and **headers**, edit the CSV in a spreadsheet,
then re-import it — using **Preserve existing terms** if you're bringing it into a
different site and want to avoid touching terms that already exist. This is also
how you migrate a term hierarchy between two Drupal sites, or rebuild a vocabulary
from an earlier export.
