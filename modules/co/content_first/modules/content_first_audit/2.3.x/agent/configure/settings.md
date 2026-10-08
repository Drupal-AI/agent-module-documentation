# Configure Content First Audit

No `configure` key in info.yml, but the submodule ships a settings form and a config object.

## Settings form

`admin/config/content/content-first-audit/settings` (route `content_first_audit.settings`, form
`ContentFirstAuditSettingsForm`, permission **`administer site configuration`**). A single
`checkboxes` element picks which **node bundles** are audited.

- Config object **`content_first_audit.settings`** (schema `content_first_audit.settings`):
  key `entity_types.node` = array of tracked bundle machine names. Install default `entity_types: {}`
  (empty = **all** bundles audited).
- On submit, if the selection changed, a Batch runs two stages via `entity_registry.processor`:
  `batchClear` (wipe stored audit data + mark tracker PENDING) then `batchRebuild`
  (delete tracker rows and re-discover matching content). The audit table is repopulated later
  when **cron** processes the PENDING queue — saving settings does not audit synchronously.

## Reports & routes

| Route | Path | Permission |
|---|---|---|
| `content_first_audit.overview` | `/admin/reports/content-first-audit` | `administer content_first` |
| `view.content_first_audit.page_1` | (Views "Table" tab) | `administer content_first` |
| `content_first_audit.node_audit` | `/node/{node}/content-first/audit` | `administer content_first` |
| `content_first_audit.settings` | `/admin/config/content/content-first-audit/settings` | `administer site configuration` |

Menu links: report under *Reports*, settings under *Configuration → Content*. The node audit tab
sits under the parent `content_first` node tab.

## Notes

- Tracking is driven by Entity Registry; ensure `entity_registry` is enabled and cron runs to
  populate/refresh `{content_first_audit}`.
- `content_first_audit_check_info` alter lets other modules add/remove `ContentAuditCheck` plugins
  (see plugins/audit-checks.md).
- Which metatag columns appear in the report follows Content First's `allowed_metatags` setting
  (cache tag `config:content_first.settings`).
