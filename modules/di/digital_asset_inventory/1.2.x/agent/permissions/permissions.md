# Permissions & access checks

## Permissions (`digital_asset_inventory.permissions.yml`)
None are marked `restrict access: TRUE`, so all are grantable to non-superadmin roles — scope
them deliberately.

| Permission | Gates |
|---|---|
| `administer digital assets` | Full management + all settings sub-forms (`…/settings`, `…/archive`, `…/registry`). |
| `view digital asset inventory` | Inventory + dashboard pages (`/admin/digital-asset-inventory/dashboard`). |
| `scan digital assets` | Run scans (`…/scan`) and the Resolve External Titles form (`…/resolve-titles`). |
| `delete digital assets` | Delete an asset from the inventory (`…/delete/{item}`). |
| `archive digital assets` | Queue/execute/cancel/unarchive, manual archive add/edit/delete, delete archived file, toggle visibility, retroactive attestation, archive CSV export, page autocomplete/title lookup, add archive notes. |
| `view digital asset archives` | Read-only archive management + notes (via `_dai_archive_view_access`). |
| `view digital asset orphan references` | View orphan paragraph reference details. |

Note `archive digital assets` bundles many state-changing archive operations — grant only to roles
trusted with archival/records management.

## Custom access checks (feature-flag gates, `*.services.yml`)
Layered on top of the permissions above via route requirements:
- `_dai_archive_enabled` → `ArchiveAccessCheck` — allowed only if config `enable_archive` is true.
- `_dai_manual_archive_enabled` → `ManualArchiveAccessCheck` — requires `enable_manual_archive`.
- `_dai_archive_view_access` → `ArchiveViewAccessCheck` — allowed if the user has
  `archive digital assets` OR `view digital asset archives`.
- `_dai_title_resolution_enabled` → `TitleResolutionAccessCheck`.

So archive routes need BOTH the relevant permission AND the feature flag on.

## Public archive registry (public by design)
`/archive-registry/{digital_asset_archive}` (`ArchiveDetailController::view`) carries only
`_dai_archive_enabled` (no `_permission`), i.e. it is publicly reachable **by design** (a public
reference registry). The controller itself enforces disclosure per archive status:
- `archived_public` → full details to everyone.
- `archived_admin` → limited info to anon (no file URL/download); full to admins.
- `archived_deleted` / `exemption_void` / `queued` → 404 for anon; admins with
  `view digital asset archives` see audit details.
Visibility is toggled via the `ToggleArchiveVisibilityForm` (needs `archive digital assets`).
