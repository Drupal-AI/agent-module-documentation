<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `cms_content_sync.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer cms content sync` | Full admin: the whole `/admin/config/services/cms_content_sync` UI (site, syndication, flows, pools). This is the `configure` route permission — **elevated**, grants control over all syndication config. |
| `access cms content sync content overview` | The Content Sync content overview pages. |
| `publish cms content sync changes` | Publish pending Content Sync changes. |
| `view cms content sync syndication status` | Shows the "Sync status" tab on content items; admins additionally see the serialized content. |
| `show entity type differences` | Button to find entity-type differences between connected sites. |
| `restful get cms_content_sync_preview_resource` | REST access to the preview resource. |
| `restful put cms_content_sync_sync_core_entity_item` | REST permission that lets a caller **push entities** into this site. |
| `restful get cms_content_sync_import_entity` | REST access to the import-entity GET interface. |
| `restful post cms_content_sync_import_entity` | REST access to the import-entity POST interface. |

The `restful *` permissions gate the REST resources the Sync Core backend uses to push and
pull entities; they are normally granted to the dedicated `cms_content_sync` user role
(shipped in `config/install/user.role.cms_content_sync.yml`), not to humans. Granting the
push/import permissions to an untrusted role would let that caller write entities into the
site.
