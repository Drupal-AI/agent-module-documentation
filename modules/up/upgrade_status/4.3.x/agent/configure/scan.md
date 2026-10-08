# Run scans & settings

UI form `UpgradeStatusForm` at `/admin/reports/upgrade-status` (route `upgrade_status.report`,
permission `administer software updates`). Lists projects split into **Custom** and **Contributed**,
each scannable individually or all at once; a batch runs PHPStan over selected extensions.

Result grouping (used by `hook_upgrade_status_result_alter` `$group_key`): `rector`, `now`,
`uncategorized`, `later`, `ignore`.

Routes:
- `upgrade_status.report` — main form/dashboard.
- `upgrade_status.project` — `/…/project/{project_machine_name}` per-project results.
- `upgrade_status.export` — `/…/export/{project_machine_name}/{format}` HTML/ASCII export.
- `upgrade_status.analyze` — POST-only `/…/analyze/{project_machine_name}` triggers a scan.

## Settings (config `upgrade_status.settings`)
Single key, editable as config (no dedicated settings form field beyond the report):
```yaml
paths_per_scan: 30   # files scanned per batch iteration; lower it if PHPStan runs out of memory
```
Schema: `config/schema/upgrade_status.schema.yml` (`paths_per_scan`: integer). Change via
`drush config:set upgrade_status.settings paths_per_scan 15`.

Environment checks (PHP version, database engine/version, deprecated core extensions) are computed
at scan time and shown on the report — no configuration.
