# Configuration

Using HTML Tag Usage is a short cycle: choose which fields to scan, generate the
report, then inspect the results to plan how you'll tighten your text formats.

## Grant the permissions

The module provides three permissions, so you can separate who can *view* results
from who can *run* the (potentially expensive) analysis. On **People → Permissions**
(`/admin/people/permissions`):

- **View HTML tag usage report** — read the report and the inspection dialogs. Good
  for auditors who only need to look.
- **Generate HTML tag usage report** — trigger (and re‑trigger) the analysis batch.
- **Administer HTML tag usage** — change which field types are scanned.

## Step 1 — Choose which fields to scan

1. Go to **Configuration → Development → HTML Tag Usage**
   (`/admin/config/development/html_tag_usage`).
2. Select the **field types** whose contents you want analysed. By default, all the
   formatted‑text field types provided by core's Text module are selected.
3. Save.

## Step 2 — Generate the report

1. Go to **Reports → HTML Tag Usage** (`/admin/reports/html_tag_usage`).
2. Click **Generate report**. A batch process analyses every field of the selected
   types, parses each value, and records the tag/attribute counts. When it finishes
   you're taken to the generated report.
3. You can **regenerate** the report at any time after content changes — each run
   refreshes the results.

## Step 3 — Read and act on the report

- The report lists, per **text format**, each tag together with each attribute and a
  **count** of how often it appears. An attribute shown as `*` means the tag is used
  with no attributes.
- Click a **count** to open a dialog listing the exact entities that use that
  tag/attribute combination, each linked to its edit form. Paragraphs are resolved
  to their host entity so you can find them.
- The report also emits a suggested **allowed‑HTML filter configuration** string per
  format, covering everything currently in use. Treat this only as a **starting
  point** — the module explicitly warns it may be insecure and must be reviewed
  before you apply it to a "Limit allowed HTML tags" filter.

## When you're done

Because the results table can grow large, uninstall the module once your audit is
complete (see [Installation](../installation/index.md)) to drop the table.
