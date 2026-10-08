<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types OG defines (and the plugins it ships)

Three own plugin types, each with a PHP attribute in `Drupal\og\Attribute` (legacy annotations
in `Drupal\og\Annotation` still work).

## 1. `og_fields` — `plugin.manager.og.fields`

Describes a field OG can attach with `Og::createField($plugin_id, $entity_type, $bundle)`.
Base class `Drupal\og\OgFieldBase`, interface `OgFieldsInterface`.

| Plugin id | Class | Purpose |
|---|---|---|
| `og_audience` | `Plugin\OgFields\AudienceField` | the group audience reference field (default field name `og_audience`, type `og_standard_reference`, handler `og:default`) |
| `og_access` | `Plugin\OgFields\AccessField` | group visibility field; node entities only |

Implement one by extending `OgFieldBase` and providing
`getFieldStorageBaseDefinition()`, `getFieldBaseDefinition()`, `getFormDisplayDefinition()`,
`getViewDisplayDefinition()`:

```php
use Drupal\og\Attribute\OgFields;
use Drupal\og\OgFieldBase;
use Drupal\og\OgFieldsInterface;

#[OgFields(id: 'my_og_field', type: 'group', description: new TranslatableMarkup('…'))]
class MyOgField extends OgFieldBase implements OgFieldsInterface { … }
```

## 2. `og_delete_orphans` — `plugin.manager.og.delete_orphans`

Strategy for removing group content when its group is deleted. Selected by
`og.settings:delete_orphans_plugin_id` (only used when `delete_orphans: true`).
Base class `OgDeleteOrphansBase`, interface `OgDeleteOrphansInterface`.

| Plugin id | Behaviour |
|---|---|
| `simple` | delete immediately, in the same request |
| `batch` | queue the orphans and run a Batch API operation |
| `cron` | queue the orphans and let cron drain them |

Queue name: `og_orphaned_group_content`; the cron worker plugin is
`og_orphaned_group_content_cron` (`Plugin\QueueWorker\DeleteOrphan`).
`drush queue:run og_orphaned_group_content` processes it manually.

## 3. `og_group_resolver` — `plugin.manager.og.group_resolver`

Discovers the "current group" for `og.context`. Ordered list in
`og.settings:group_resolvers`; base classes `OgGroupResolverBase` /
`OgRouteGroupResolverBase`, collection object `OgResolvedGroupCollection`.

| Plugin id | Resolves from |
|---|---|
| `route_group` | a group entity in the current route |
| `route_group_content` | a group-content entity in the current route → its groups |
| `request_query_argument` | an `og_group_*` query argument |
| `user_access` | the groups the current user is a member of |

```php
#[OgGroupResolver(id: 'my_resolver', label: new TranslatableMarkup('My resolver'))]
class MyResolver extends OgGroupResolverBase {
  public function resolve(OgResolvedGroupCollectionInterface $collection): void { … }
}
```
Add the id to `og.settings:group_resolvers` for it to run.

## Core plugin types OG implements

| Type | Ids |
|---|---|
| Field type | `og_standard_reference`, `og_group` |
| Field widget | `og_autocomplete` |
| Field formatter | `og_group_subscribe` |
| EntityReferenceSelection | `og:default` (`OgSelection`), `og:user`, `og:og_role` |
| Block | `og_member_count`, `og_recent_group_content` |
| Condition | `og_group_type` (block visibility by group bundle) |
| Action | `og_membership_add_single_role_action`, `og_membership_remove_single_role_action`, `og_membership_add_multiple_roles_action`, `og_membership_remove_multiple_roles_action`, `og_membership_approve_pending_action`, `og_membership_pending_action`, `og_membership_block_action`, `og_membership_unblock_action`, `og_membership_delete_action` |
| Views relationship | `og_group_to_group_content`, `og_group_content_to_group` |
| Views argument default | `og_group_context`, `og_group_membership` |
| Views argument validator | `og_group` (`Plugin\views\argument_validator\Group`) |
| Views field | `og_membership_bulk_form` |
| Validation constraints | `UniqueOgMembership`, `ValidOgMembershipReference`, `ValidOgRole` |
| Cache contexts | `og_group_context`, `og_membership_state`, `og_role`, `og_permissions` |
| Deriver | `OgActionLink` (member add links), `OgLocalTask` (group admin tabs) |

Ships the optional view `views.view.og_members_overview` (base table `og_membership`).
