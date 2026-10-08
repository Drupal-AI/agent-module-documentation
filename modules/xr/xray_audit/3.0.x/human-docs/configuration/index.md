# Configuration

Most of Xray Audit is just viewing reports — no configuration required. The one
settings form tunes the thresholds used to flag "excessive" values.

## The settings form (thresholds)

Go to **Configuration → Development → Xray Audit → Settings**
(`/admin/config/development/xray_audit/settings`). You need the **Xray Audit
administer configuration** permission. The form has three thresholds, stored in
`xray_audit.settings`:

| Setting | Meaning |
|---|---|
| **Node revisions threshold** | Node revision count considered excessive (used by the revision-bloat report and by the Insight submodule). |
| **Paragraph revisions threshold** | Paragraph revision count considered excessive. |
| **Table size threshold (MB)** | Database table size, in MB, above which a table is flagged as large. |

No default values ship, so set them here (or with Drush) to enable the flagging:

```bash
ddev drush cset xray_audit.settings revisions_thresholds.node 20 -y
ddev drush cset xray_audit.settings revisions_thresholds.paragraph 20 -y
ddev drush cset xray_audit.settings size_thresholds.tables 500 -y
```

## Whitelisting admin views for the anonymous-views audit

One report flags admin views that are reachable by anonymous users. Some core views
(for example the Media Library widgets) are *meant* to be reachable and would
otherwise be false-flagged. They are whitelisted in a separate config object,
`xray_audit.views_report`:

```yaml
admin_views_anonymous:
  - 'media_library.widget'
  - 'media_library.widget_table'
```

Add your own view ids to that list to stop the audit from flagging views you know
are intentionally public.

## Viewing and refreshing reports

The reports themselves live at **Reports → Xray Audit Reports**
(`/admin/reports/xray-audit`), gated by the **Xray Audit access** permission. Report
data is cached in a dedicated `xray_audit` cache bin for speed. The report home page
includes a **Flush cache** button to rebuild the data on demand; a normal
`ddev drush cr` also clears it. Uninstalling the module drops the bin.

Each report can be downloaded as a CSV, and there is a batch **"Download all reports
as CSV"** action that zips them into a single file.

## Permissions and route access

Two permissions, both marked *restrict access* (grant to trusted roles only):

| Permission | Grants |
|---|---|
| **Xray Audit access** | Viewing all report pages, the per-report tabs, and the CSV/ZIP downloads. |
| **Xray Audit administer configuration** | The settings form and the development pages. |

## Drush commands

Three read-only commands back the node/paragraph usage reports so you can script
them:

| Command | Does |
|---|---|
| `xray_audit:node_count` | Counts published nodes, grouped. |
| `xray_audit:paragraph_count` | Counts paragraph bundles that are in use. |
| `xray_audit:usage_place <node\|paragraph> [--bundles=a,b] [--parents=a,b]` | Lists where the given node/paragraph bundles are used. `--bundles` is a comma list of bundle machine names; `--parents` a comma list of parent entity types (defaults to `node`). |

Examples:

```bash
ddev drush xray_audit:node_count
ddev drush xray_audit:paragraph_count
ddev drush xray_audit:usage_place paragraph --bundles=hero,cta --parents=node
```

These commands only read data; they make no changes.
