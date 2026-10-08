<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & routes

## Permissions (`n1ed.permissions.yml`)
- `administer flmngr files` ("Manage files and images") — gates the Flmngr file-manager backend routes and the
  file-field integration. **Not** marked `restrict access: true`, so it is meant to be grantable to content
  editors, not only site admins. Holders can list/upload/rename/move/copy/delete/resize files under
  `public://flmngr`.
- `administer n1ed configuration` ("Change N1ED settings") — gates the API-key and Flmngr toggle POST endpoints.

## Routes (`n1ed.routing.yml`)
| Route | Path | Method | Requirement |
|---|---|---|---|
| `n1ed.flmngr` | `/flmngr` | any | `administer flmngr files` + CSRF header token |
| `n1ed.flmngrLegacy` | `/flmngr-legacy` | any | `administer flmngr files` + CSRF header token |
| `n1ed.setApiKey` | `/admin/config/n1ed/setApiKey` | POST | `administer n1ed configuration` + CSRF header token |
| `n1ed.config` | `/admin/config/content/n1ed` | GET | `administer site configuration` |
| `n1ed.useFlmngrOnFileFields` | `/admin/config/n1ed/toggleUseFlmngrOnFileFields` | POST | `administer n1ed configuration` |
| `n1ed.useLegacyFlmngrBackend` | `/admin/config/n1ed/toggleUseLegacyFlmngrBackend` | POST | `administer n1ed configuration` |

The `/flmngr` controller (`FlmngrController::flmngr`) dispatches to `FlmngrServer::flmngrRequest()`, which routes
the `action` POST/GET param to `FileSystem` methods (`uploadFile`, `dirCreate`, `fileDelete`, `fileMove`, …).
Path arguments are checked for `..` (traversal blocked) and confined to `public://flmngr`.
