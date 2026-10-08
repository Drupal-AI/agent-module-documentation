# Configuration

Using Paragraphs Report is a three-part rhythm: **choose what to scan**, **build the
report**, then **read or export it**. This page covers the settings and permissions.

## Choose what to scan (the Settings tab)

Go to **Reports → Paragraphs Report → Settings**
(`/admin/reports/paragraphs-report/settings`). You need the **Administer
paragraphs_report configuration** permission. The options:

- **Content types** — tick the node types you want the report to cover. Nothing is
  scanned until at least one type is selected, so this is the first thing to set.
- **Hide paragraphs** — tick any paragraph types you want to leave out of the report's
  filter dropdown, to cut noise from components you do not care about.
- **Rows per batch** — how many nodes are processed per batch when the report is
  rebuilt (default **10**). Raise it on fast servers, or lower it if a rebuild times
  out on sites with many paragraphs per node.
- **Watch content** — off by default. When on, the report updates itself automatically
  whenever a node is added, changed, or deleted, so it stays current without you
  clicking anything.

Save with **Save configuration**. These settings are stored as ordinary
configuration, so they can be exported and deployed.

## Build the report

The settings only say *what* to scan — you still have to run the scan to produce the
data. There are two equivalent ways:

- **From the UI** — on the report page (`/admin/reports/paragraphs-report`), click
  **Update Report Data**. This button is only shown to users with the **Update report
  data** permission. The rebuild runs as a batch so it will not time out.
- **From the command line** — run `drush paragraphs_report:update` (or the short alias
  `drush pru`). This is the same rebuild, handy for cron or deployments. If no content
  types are selected it will tell you there is nothing to process, so set the content
  types first.

Rebuild whenever you change which content types are selected. (If **Watch content** is
on, day-to-day node edits keep the data fresh automatically, but you should still
rebuild after changing the selection.)

## Read and export the report

The report page (`/admin/reports/paragraphs-report`) shows a paginated table you can
filter by paragraph type or by parent type (node versus paragraph), with counts of how
often each paragraph type appears and a Path column tracing each instance back to its
node. A **CSV export** at `/admin/reports/paragraphs-report/export` gives you the same
data for a spreadsheet or external analysis. Viewing and exporting both require the
**Access paragraphs report** permission.

## Permissions

Three permissions, all flagged as security-sensitive, appear on **People →
Permissions**:

- **Administer paragraphs_report configuration** — change the settings (content types,
  hidden paragraphs, batch size, watch toggle).
- **Access paragraphs report** — view the report and use the CSV export.
- **Update report data** — trigger a rebuild via the **Update Report Data** button.

Note the `drush paragraphs_report:update` command runs as the command-line user and is
not gated by these permissions.

## Where the data is stored

Only the *settings* are configuration. The report **data** itself lives in Drupal's
key-value store, not in exportable config — so it does not travel with a configuration
export. On a new environment, run the update (UI button or `drush pru`) to generate the
data there.
