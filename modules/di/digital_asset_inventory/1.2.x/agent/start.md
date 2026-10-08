# Digital Asset Inventory — agent index

Scans a site for all digital assets (files, media, orphaned files, external/embedded links), maps
usage, resolves titles, evaluates alt-text/accessibility signals, exports CSV reports, and offers
an ADA Title II archiving workflow. Depends on `file`, `media`, `views`,
`better_exposed_filters`, `views_data_export`, `csv_serialization`. Provides permissions, config
schema, and Drush commands.

- **Settings (scanner / archive / registry sub-forms) and the `digital_asset_inventory.settings`
  config keys, feature flags, asset-type map** → [configure/settings.md](configure/settings.md)
- **The 7 permissions + custom access checks / feature-flag route requirements** →
  [permissions/permissions.md](permissions/permissions.md)
- **`drush dai:scan` / `dai:status`** → [drush/commands.md](drush/commands.md)
- **Services (scanner, archive, title resolver, dashboard, signal detector) & entities** →
  [api/services.md](api/services.md)
- **`hook_digital_asset_inventory_title_resolve_alter()`** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- `configure` = `digital_asset_inventory.settings` → `/admin/config/accessibility/digital-asset-inventory`.
- Entities: `digital_asset_item`, `digital_asset_usage`, `digital_asset_orphan_reference`,
  `digital_asset_archive`, `digital_asset_archive_note`.
- Archive features are **off by default** (`enable_archive`, `enable_manual_archive` = false).
  Routes are gated by permissions AND feature-flag access checks (`_dai_archive_enabled`,
  `_dai_manual_archive_enabled`, `_dai_archive_view_access`).
- Public route `/archive-registry/{digital_asset_archive}` has no `_permission` (only
  `_dai_archive_enabled`); the `ArchiveDetailController::view()` enforces per-status visibility
  (public → full; admin-only → limited/404 for anon; deleted/queued → 404 for anon).
- External title resolution is **SSRF-guarded** (`TitleResolverService::isSafeUrl()` rejects
  private/reserved IPs; redirects disabled and re-checked).
- Shipped optional role `digital_asset_manager` (`config/optional`). Views ship in `config/install`.

Access is permission/feature-flag gated, the public archive page enforces visibility
in-controller, and outbound fetches are guarded against internal targets.
