<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions, field-access & Views integration

Source: `src/AccessByTaxonomyPermissions.php`, `access_by_taxonomy.permissions.yml`,
`access_by_taxonomy.module`, `src/Plugin/views/filter/NodeStatus.php`,
`access_by_taxonomy.views.inc`, `access_by_taxonomy.views_execution.inc`.

## Dynamic permissions

`access_by_taxonomy.permissions.yml` declares two `permission_callbacks` on
`AccessByTaxonomyPermissions` (uses `BundlePermissionHandlerTrait`):

- `nodeTypePermissions()` → per node type: **`access by taxonomy view any <type_id> content`**
  (title "View any %type_name content"). Held accounts get a `view_any_<type>` grant (gid 1),
  letting them view every node of that type regardless of tags, and — via the Views takeover below —
  see them in listings including unpublished ones.
- `taxonomyVocabularyPermissions()` → per vocabulary: **`access by taxonomy administer access for
  terms in <vid>`** (title "Administer access for terms in %type_name"). Controls who may edit the
  two access fields on that vocabulary's terms.

No static permissions.yml keys, no routes, no admin/config form ship with the module.

## Field-edit access — `hook_entity_field_access`

Only acts on `edit` of `taxonomy_term` fields named `field_allowed_roles` / `field_allowed_users`.
Returns `AccessResult::forbiddenIf(!$condition)` where `$condition` = the account holds
`access by taxonomy administer access for terms in <bundle>` **or** `administer taxonomy`. So term
editors cannot change access rules unless explicitly granted (README: default is admins +
`administer taxonomy` only). Neutral for every other field/operation.

## Views "Published status or admin" filter takeover

`access_by_taxonomy.views.inc` → `hook_views_plugins_filter_alter` swaps the core `node_status`
filter's class for `Drupal\access_by_taxonomy\Plugin\views\filter\NodeStatus` (extends core
`node\...\filter\Status`).

`NodeStatus::query()` keeps core's snippet
(`status = 1 OR (uid = ***CURRENT_USER*** AND ... ***VIEW_OWN_UNPUBLISHED_NODES*** = 1) OR
***BYPASS_NODE_ACCESS*** = 1`, plus `***VIEW_ANY_UNPUBLISHED_NODES***` when content_moderation is
on) and appends, per node type, `(type = '<type>' AND ***ACCESS_BY_TAXONOMY_VIEW_ANY_TYPE_<type>*** =
1)`. So a "view any <type>" holder also sees that type's unpublished nodes in a view using the
default status filter.

`access_by_taxonomy.views_execution.inc` → `hook_views_query_substitutions` resolves each
`***ACCESS_BY_TAXONOMY_VIEW_ANY_TYPE_<type>***` placeholder to `(int) $account->hasPermission('access
by taxonomy view any <type> content')` for the current user.

## Node-form access preview (AJAX)

`hook_form_node_form_alter` adds an "Access By Taxonomy" details group showing current stored grants
(`describeGrants()`) and a "Preview access changes" button whose AJAX callback
`AccessByTaxonomyService::nodeChangedAccessDiff` validates the submitted form, recomputes grants, and
renders a YAML diff (`Drupal\Component\Diff\Diff`) in a modal — read-only preview, no persistence.
`hook_form_taxonomy_term_form_alter` groups the two access fields into a "Permissions" details
element.
