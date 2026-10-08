# CSV Importer — manual setup guide

**CSV Importer** (`csv_importer`) bulk‑creates or updates Drupal content entities
— nodes, users, taxonomy terms, media, and any other content entity type — from
an uploaded CSV file. You pick the entity type and bundle, upload a UTF‑8 CSV
whose first row holds the target field machine names, and each following row
becomes one entity. There is no mapping UI to wire up and no configuration
required: the column headers *are* the mapping.

It handles the tricky parts of a real import. Large files run through Drupal's
Batch API so they don't time out. A header cell can target several properties of a
composite field with a pipe (`body|value|format`), and a single cell can fill a
multi‑value field using `values(a+b+c)` syntax. Cells that contain a file URI
(`public://…`) or an `http`/`https` URL are downloaded and saved as managed files
automatically (bare local paths are rejected). If a row includes an
entity's ID column (like `nid` or `uid`), the matching entity is loaded and
**updated** instead of created — and a `langcode` column lets you import
translations. Rows are processed one at a time: a row that can't be saved (for
example a missing required field) is **skipped and reported**, and the rest of the
CSV still imports.

Every import is logged to a history page, and a mistaken import can be **reverted**
— deleting the entities it created. The module adds a single admin form under
Content, is gated by one permission, and has **no settings form, no config
entities, and no Drush commands**. It depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the parser
service, the importer plugin type, and the pre‑import hook — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The import form is at **Content → Import CSV** (`/admin/content/csv-importer`),
and the history of past imports (with the revert links) is at
`/admin/content/csv-importer/history`. Both require the **Access CSV Importer**
permission.

## How to use it

1. Enable the module and grant the **Access CSV Importer** permission to the roles
   that should import (it's a restricted permission — keep it to trusted users).
2. Go to **Content → Import CSV**.
3. **Select entity type** — choose what you're importing (Content/node, User,
   Taxonomy term, Media, etc.).
4. **Select bundle** — shown for entity types that have bundles (e.g. which
   content type); required in that case.
5. **Select delimiter** — one of `,` `~` `;` `:` (default comma). Pick a
   non‑comma delimiter if your data contains commas.
6. **Upload the CSV file** — it must be **UTF‑8** and have the `.csv` extension.
7. Press **Import**. The work runs as a batch.

### Preparing the CSV

- **Row 1 is the header** — the machine names of the fields you're setting (e.g.
  `title`, `body`, `field_tags`). Make sure every field the bundle marks required
  is present as a column; a row that leaves a required field empty is skipped and
  named in the results, while the other rows still import.
- **Each later row is one entity.** Empty cells are skipped.
- **Target a field property** with a pipe: `body|value|format`.
- **Fill a multi‑value field from one cell** with `values(a+b+c)` or
  `multiple(a+b+c)`.
- **Attach files/images** by putting a `public://path/file.jpg` URI or an
  `https://…` URL in the cell — it's downloaded and saved as a managed file. Bare
  local filesystem paths are rejected.
- **Update instead of create** by including the entity's ID column (`nid`, `uid`,
  `tid`); if that entity exists it's loaded and updated.
- **Import translations** by adding a `langcode` column.

### History and undo

Every import that adds or updates content is recorded at
**`/admin/content/csv-importer/history`** (file, entity type, count, date,
status). If an import was a mistake, use its **revert** link there to delete the
entities that import created.
