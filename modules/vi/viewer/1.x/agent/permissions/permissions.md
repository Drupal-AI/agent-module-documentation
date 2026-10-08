<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `viewer.permissions.yml`, plus the REST permission `restful get viewer` provided by core
REST for the module's resource. The two content entities use per-operation permissions enforced by
`Entity/AccessControl/ViewerAccessControlHandler` and `ViewerSourceAccessControlHandler`.

## Viewer entity

| Permission | Gates |
|------------|-------|
| `administer viewer` | Entity `admin_permission`; the collection UI `/admin/structure/viewers`, and all entity operations lacking a more specific route requirement. `restrict access: true`. |
| `add viewer` | Create a viewer; `entity.viewer.new`, the `viewer.new_configuration` / `viewer.new_settings` forms, and the iframe preview routes. |
| `edit viewer` | `update` op (edit form). |
| `delete viewer` | `delete` op. |
| `view active viewer` | `view` op when the viewer is published. |
| `view inactive viewer` | `view` op when the viewer is unpublished. |

## Viewer Source entity

| Permission | Gates |
|------------|-------|
| `administer viewer source` | Entity `admin_permission`; `/admin/structure/viewer-source` collection + default entity ops. `restrict access: true`. |
| `add viewer source` | Create a source (`entity.viewer_source.new`, `viewer_source.new_source`), plus per-source `import`, `download`, and the `import` op. |
| `edit viewer source` | `update` op. |
| `delete viewer source` | `delete` op. |
| `view active viewer source` | `view` op when active. |
| `view inactive viewer source` | `view` op when inactive. |
| `bulk import viewer source` | `entity.viewer_source.bulk_import` (re-import all sources). |

## Other access

- `restful get viewer` — reads the `/get/viewer/{uuid}` JSON endpoint. `viewer_install()` grants it
  to `authenticated` and `anonymous` (and `viewer_uninstall()` revokes it). This is the permission
  the on-page JS relies on; leaving anonymous with it is required for viewers embedded on
  anonymously-viewable pages to load.
- `viewer.support` route requires core `administer site configuration`.
- CKEditor routes require `use text format advanced` (dialog) and `use text format <format>`
  (preview access callback).

Notes:
- `add viewer source` is **not** marked `restrict access: true`. It is the permission that lets a
  user point a source at an absolute path, remote URL, or FTP/SFTP host and download the result, so
  treat it as a trusted permission rather than a routine content-editor one.
