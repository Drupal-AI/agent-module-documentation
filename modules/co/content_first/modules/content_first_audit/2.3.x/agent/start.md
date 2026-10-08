# Content First Audit — agent index

Submodule of `content_first`. Audits rendered node content for heading, image-alt and metatag
problems via an Entity Registry consumer, stores counts in the `content_first_audit` table, and
reports them in Views + the status page. Depends on `content_first` and `entity_registry`. No
`configure` key in info.yml, but ships a settings form and a config object.

- **The `ContentAuditCheck` plugin type, shipped checks, the consumer & storage** →
  [plugins/audit-checks.md](plugins/audit-checks.md)
- **Bundle-tracking settings + report/route map** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Consumer `ContentAuditConsumer` (`#[EntityRegistryConsumer(id: 'content_first_audit')]`) processes
  **nodes only**, renders via `content_first.builder`, runs checks, upserts one row per
  entity+langcode into `{content_first_audit}` (schema in `.install`).
- Plugin type `ContentAuditCheck`: attribute `Drupal\content_first_audit\Attribute\ContentAuditCheck`
  (`id`, `label`, `storage_column`), interface `ContentAuditCheckInterface::run(\DOMXPath, string): ContentAuditCheckResult`,
  manager service `content_first_audit.check_manager` (dir `Plugin/ContentAuditCheck`, alter
  `content_first_audit_check_info`).
- Routes: report `/admin/reports/content-first-audit` + Views `view.content_first_audit.page_1`
  (`administer content_first`); per-node `/node/{node}/content-first/audit`
  (`administer content_first`); settings `/admin/config/content/content-first-audit/settings`
  (`administer site configuration`).
- Config object `content_first_audit.settings` → `entity_types.node` = tracked bundles (`{}` = all).
- All routes are admin-gated (`administer content_first` / `administer site configuration`,
  `administer menu` n/a).
