# Plugin type: `GroupRelationType` — make an entity type groupable

A **group relation** plugin declares that a given entity type can be related to groups. It is
the v3 replacement for the v1/v2 `GroupContentEnabler` plugin type.

- **Attribute:** `Drupal\group\Plugin\Attribute\GroupRelationType` (object-based; there is also
  a legacy `Drupal\group\Annotation\GroupRelationType`).
- **Discovery namespace:** `Plugin\Group\Relation` (i.e. `src/Plugin/Group/Relation/`).
- **Base class:** `Drupal\group\Plugin\Group\Relation\GroupRelationBase` implementing
  `GroupRelationInterface`.
- **Manager service:** `group_relation_type.manager`
  (`Drupal\group\Plugin\Group\Relation\GroupRelationTypeManager`).

## Minimal plugin

```php
namespace Drupal\my_module\Plugin\Group\Relation;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\group\Plugin\Attribute\GroupRelationType;
use Drupal\group\Plugin\Group\Relation\GroupRelationBase;

#[GroupRelationType(
  id: 'group_my_entity',
  entity_type_id: 'my_entity',
  label: new TranslatableMarkup('Group my entity'),
  description: new TranslatableMarkup('Adds my_entity items to groups.'),
  reference_label: new TranslatableMarkup('Title'),
  reference_description: new TranslatableMarkup('The item to add to the group'),
  entity_access: TRUE,
)]
class GroupMyEntity extends GroupRelationBase {}
```

## Attribute properties (all keys)

`id`, `entity_type_id` (required), `label`, `description`, `reference_label`,
`reference_description`, `entity_bundle` (string|false — restrict to one bundle),
`shared_bundle_class` (a bundle class shared by the relationship, as `GroupMembership` uses),
`entity_access` (bool — route entity access through group access), `admin_permission`,
`pretty_path_key` (default `content`), `enforced` (bool — installed automatically on every
group type), `code_only`, `deriver`, `additional`.

Use a **deriver** to create one plugin per bundle — `gnode`'s `GroupNodeDeriver` derives a
`group_node:{node_type}` plugin per node type. Set `enforced: TRUE` (as `group_membership`
does) to force-install the plugin on every group type.

## Handlers (one per plugin, resolved by the manager)

A plugin's behaviour is split into swappable handlers, fetched from the manager:

| Getter | Default class | Overridable service |
|---|---|---|
| `getAccessControlHandler($id)` | `RelationHandlerDefault\AccessControl` | `group.relation_handler.access_control` |
| `getEntityReferenceHandler($id)` | `RelationHandlerDefault\EntityReference` | `group.relation_handler.entity_reference` |
| `getOperationProvider($id)` | `RelationHandlerDefault\OperationProvider` | `group.relation_handler.operation_provider` |
| `getPermissionProvider($id)` | `RelationHandlerDefault\PermissionProvider` | `group.relation_handler.permission_provider` |
| `getPostInstallHandler($id)` | `RelationHandlerDefault\PostInstall` | `group.relation_handler.post_install` |
| `getUiTextProvider($id)` | `RelationHandlerDefault\UiTextProvider` | `group.relation_handler.ui_text_provider` |

Provide a plugin-specific handler by registering a service like
`group.relation_handler.permission_provider.<plugin_id>` (see how `group_membership` supplies
`GroupMembershipPermissionProvider`), or decorate a default handler to affect every plugin (see
[extend/group.md](../extend/group.md)).

## Other manager methods

`getInstalled($group_type)`, `getInstalledIds($group_type)`, `getAllInstalledIds()`,
`getPluginIdsByEntityTypeId($id)`, `getPluginIdsByEntityTypeAccess($id)`,
`installEnforced($group_type)`, `getRelationshipTypeIds($plugin_id)`,
`getPluginGroupRelationshipTypeMap()`, `getGroupTypePluginMap()`.

Alter discovered definitions with `hook_group_relation_type_alter()`.
