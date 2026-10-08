# Configure Xray Audit

`configure` in `xray_audit.info.yml` is null, but there **is** a settings form.

- Settings form: route `xray_audit.settings` → `/admin/config/development/xray_audit/settings`
  (`Form/SettingsForm`, a `ConfigFormBase`). Menu: *Config → Development → Xray Audit → Settings*.
  Gated by permission `xray_audit administer configuration`.
- Report UI (no config, just viewing): `/admin/reports/xray-audit`, gated by `xray_audit access`.

## `xray_audit.settings` (thresholds)

Used by reports (and by xray_audit_insight) to flag "excessive" values. Schema
`config/schema/xray_audit.schema.yml`.

| Key | Type | Meaning |
|---|---|---|
| `revisions_thresholds.node` | int (required) | Node revision count considered excessive. |
| `revisions_thresholds.paragraph` | int (required) | Paragraph revision count considered excessive. |
| `size_thresholds.tables` | int | Database table size (MB) considered excessive. |

No default values ship in `config/install`; set them via the form or config:

```bash
ddev drush cset xray_audit.settings revisions_thresholds.node 20 -y
ddev drush cset xray_audit.settings revisions_thresholds.paragraph 20 -y
ddev drush cset xray_audit.settings size_thresholds.tables 500 -y
```

`SettingsForm::submitForm()` writes every cleaned form value straight into the config object
(`$config->set($key, $value)`), so the config keys mirror the form's `#tree` structure exactly.

## `xray_audit.views_report`

Separate config object (schema + `config/install/xray_audit.views_report.yml`) listing admin
views that are *expected* to be reachable by anonymous users, so the Views report doesn't
false-flag them:

```yaml
admin_views_anonymous:
  - 'media_library.widget'
  - 'media_library.widget_table'
```

Add view ids here to whitelist them in the "admin views accessible to anonymous" audit.

## Cache

Reports are cached in a dedicated bin **`xray_audit`** (service `xray_audit.cache_manager`,
backend `cache.xray_audit`). The report home page includes a **Flush cache** form
(`Form/FlushCacheForm`) to rebuild report data; `hook_uninstall` removes the bin. A normal
`ddev drush cr` also clears it. Plugin definitions are cached by the plugin managers.

## Install-time behavior

`xray_audit_install()` runs each task plugin's optional `install` method (declared via the
attribute's `install` property) — e.g. creating the temporary table used by the paragraph
hierarchy report. `hook_uninstall` runs the matching `uninstall` methods and drops the cache bin.
