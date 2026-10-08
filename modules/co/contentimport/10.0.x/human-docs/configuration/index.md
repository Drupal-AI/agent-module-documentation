# Configuration

Content Import has no persistent settings to save — the "configuration" is what you
enter on the import form each time you run it, plus the way you lay out your CSV.
This page covers both.

## Open the import form

1. Log in as a user with the core **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Content Import**, or directly to
   `/admin/config/content/contentimport`.

## The form, field by field

- **Select Content Type** — the content type (bundle) the nodes will be created in
  or updated on. Every content type on the site is listed.
- **Select Import Type** — choose one:
  - **Create New content** — makes a new node for each CSV row.
  - **Update existing content** — updates existing nodes (your CSV must include a
    `nodeid` column so the module knows which node each row refers to).
  When you change this, the form offers a **sample CSV** download — a header‑only
  file listing the exact field machine names for the selected content type. Start
  from this to get your columns right.
- **Import CSV File** — upload your `.csv` file.

Submitting runs a batch that creates or updates one node per row and then takes you
to the content listing.

## CSV rules

- **The first row is the field machine names**, not human labels — one column per
  destination field. Data rows follow.
- **Required columns:** every CSV needs a **`title`** and a **`langcode`** column (if
  `langcode` is blank, it defaults to `en`). In **Update** mode you also need a
  **`nodeid`** column.
- **Optional `author` column** — a username to set as the node's author (falls back
  to the current user if omitted).

## How each field type expects its data

The importer reads the target content type's field definitions and converts each
cell according to the field's type:

| Field type | CSV cell format |
|---|---|
| Text / long text | Stored as full HTML. Text‑with‑summary fields get an auto summary from the first part of the text. |
| Image | The file name of an image you have already placed in `public://<content_type>/images/` (upload the images first, for example with IMCE). |
| Taxonomy reference | `Vocabulary: term1, term2` — missing vocabularies and terms are **created automatically**. If the field targets a single vocabulary you can omit the vocabulary name and just list the terms. |
| User reference | Comma‑separated emails (or names); missing user accounts are **created automatically**. |
| Node reference | Colon‑separated node titles, e.g. `Title A:Title B`. |
| Date (datetime) | `m/d/Y` for a date, or `m/d/Y H:i:s` for date and time. |
| Timestamp | A raw timestamp (epoch) value. |
| Boolean | `On`/`Yes`/`on`/`yes` means checked; anything else (`Off`/`No`) means unchecked. |
| List (text) | Comma‑separated option keys. |
| Geolocation / geofield | `lat,long`; separate multiple points with `;` (e.g. `la,lo;la2,lo2`). |

Any field type not listed above receives the raw cell value as‑is.

> **Heads‑up on auto‑creation:** importing taxonomy or user references can create
> vocabularies, terms, and user accounts that did not exist before. Double‑check your
> reference columns so you do not accidentally spawn unwanted terms or users.

## After the import — check the log

Each run writes a readable log to `sites/default/files/contentimportlog.txt` (there
is a "Check Log" link on the form). Review it to confirm which fields matched and to
spot rows that did not import as expected. Remember that the module needs write
access to `sites/default/files/` for the log and sample files.

## Re‑running

You can edit your source CSV and run the import again — in **Update** mode (with
`nodeid` values) this is the way to revise a batch of nodes after correcting the
spreadsheet.
