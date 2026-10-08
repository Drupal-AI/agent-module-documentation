# Configure Xray Audit Insights

Settings form: route `xray_audit_insight.settings_form` →
`/admin/config/xray_audit_insight/settings` (`Form/SettingsForm`, a `ConfigFormBase`). It is the
module's `configure` route and is gated by core **`administer site configuration`**. Also linked
under *Config → Development → Xray Audit → Xray Audit Insight Settings*.

The form is built dynamically: for each discovered insight plugin it renders that plugin's own
`buildInsightForSettings($config)` fragment (enable/disable toggle + any thresholds), and on submit
calls each plugin's `submitInsightSettings()`.

## Config `xray_audit_insight.settings`

Schema `config/schema/xray_audit_insight.schema.yml`:

| Key | Type | Meaning |
|---|---|---|
| `excluded_insights` | sequence<string> | Insight plugin ids to hide from the Status Report. |
| `excluded_views` | sequence<string> | View ids excluded from the "views not cached" insight. |
| `node_revision_count` | int | Threshold for the "nodes with excessive revisions" insight. |
| `paragraph_revision_count` | int | Threshold for the "paragraphs with excessive revisions" insight. |
| `table_size_threshold` | int | Max table size (MB) for the "suspicious table size" insight. |

Note: some insights (e.g. `suspicious_database_table_size`) read thresholds from the **parent**
`xray_audit.settings` (`size_thresholds.tables`) rather than this config — set both if you rely on
those checks. Configure via the form, or:

```bash
ddev drush cset xray_audit_insight.settings node_revision_count 20 -y
ddev drush cset xray_audit_insight.settings table_size_threshold 500 -y
```

## Effect

Once configured, `hook_requirements('runtime')` (`xray_audit_insight_requirements`) runs on the
Status Report: each active, non-excluded insight adds a row — a `REQUIREMENT_WARNING` with a link
to the underlying Xray Audit report when the threshold is breached, otherwise an OK/neutral entry.
