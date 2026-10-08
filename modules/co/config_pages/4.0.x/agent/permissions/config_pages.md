# Permissions

Static permissions (`config_pages.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer config_pages types` | Create/edit/delete config page **types** and their fields (the entity `admin_permission`). |
| `access config_pages overview` | View the config pages library/overview page. |
| `view config_pages entity` | View all config page entities. |
| `edit config_pages entity` | Edit all config page entities (part of the collection/`configure` route requirement, alongside `access config_pages overview`). |
| `delete config_pages entity` | Delete config page entities. |
| `access config_pages clear values option` | Use the "clear/purge values" action on a config page. |
| `context import config_pages entity` | Import values from another context into a config page. |

Dynamic per-type permissions (`ConfigPagesPermissions::permissions`) — two per config page type,
generated with core's `BundlePermissionHandlerTrait` so each carries the type as a config
dependency (deleting the type revokes the permission):

| Permission pattern | Gates |
|---|---|
| `view {type} config page entity` | View the specific type's config page. |
| `edit {type} config page entity` | Edit the specific type's config page. |

The `ConfigPagesAccessControlHandler` grants **view** on `edit config_pages entity`-less users if
they hold `view config_pages entity` or the per-type `view {bundle} config page entity`, and
**update** on `edit config_pages entity` or the per-type `edit {bundle} config page entity`.
Use the per-type `edit {type} config page entity` permissions to let an editor manage only
certain config pages while `administer config_pages types` stays reserved for developers who
change the field structure.
