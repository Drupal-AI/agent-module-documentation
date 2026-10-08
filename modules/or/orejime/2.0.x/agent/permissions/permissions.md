<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orejime permissions

From `orejime.permissions.yml`. Gate the `orejime_service` consent entity and its revisions.

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer orejime entities` | **true** | Full admin incl. the global settings form and all entity operations. The intended trusted admin permission. |
| `add orejime entities` | no | Create new consent services. |
| `edit orejime entities` | no | Edit existing consent services. |
| `delete orejime entities` | no | Delete consent services. |
| `view published orejime entities` | no | View published services. |
| `view unpublished orejime entities` | no | View unpublished services. |
| `view all orejime revisions` | no | View entity revisions. |
| `revert all orejime revisions` | no | Revert a revision (also needs view-revisions + edit rights, or admin). |
| `delete all orejime revisions` | no | Delete a revision (also needs view-revisions + delete rights, or admin). |

Notes:
- The consent-service content (label/description/purposes) authored by holders of `add`/`edit`
  orejime entities is published to `drupalSettings.orejime` and rendered by the Orejime JS library
  in the consent modal — treat these editors as trusted content admins.
- Access checks in the entity storage queries use `accessCheck()` (respecting these permissions).
