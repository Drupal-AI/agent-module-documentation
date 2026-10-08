<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filters

The module implements only `views_published_or_roles_views_data_alter(&$data)`
(`views_published_or_roles.module`), which adds two filter handlers to the `node` table. Both
are Views filter plugins extending `Drupal\views\Plugin\views\filter\FilterPluginBase`.

| Views UI label | Handler id | Plugin class | Base table | Exposable? |
|---|---|---|---|---|
| Content: Published or has role | `status_has_role` | `PublishedOrHasRoles` | `node` | No (`canExpose()` = FALSE) |
| Content: Current user has roles | `current_user_has_roles` | `CurrentUserHasRoles` | `node` | No (`canExpose()` = FALSE) |

Both entries set `filter.field = status`, `filter.id = <handler id>`, `no group by = TRUE`.

## Adding a filter in the UI

1. Edit a view whose base table is Content (nodes).
2. **Filter criteria → Add**, search for **Content: Published or has role** (or **Content:
   Current user has roles**), add it.
3. In the handler settings, **Select Role(s)** — a multi-select listing your site's *custom*
   roles (anonymous and authenticated are not offered). Apply.
4. If Views also added a default **Content: Published** filter, remove it (per the module
   README), otherwise it will AND away the unpublished rows this filter is meant to admit.

The filters cannot be exposed, so a site visitor never chooses the roles — the value is fixed in
the view configuration by whoever builds the view.

## What "Published or has role" (`status_has_role`) queries

`PublishedOrHasRoles::query()` calls `$this->query->addWhereExpression($this->options['group'], …)`.
With one or more roles selected it adds this single expression (roles passed as the
placeholdered array `:roles[]`):

```sql
node_field_data.status = 1
OR (node_field_data.uid = ***CURRENT_USER*** AND ***CURRENT_USER*** <> 0 AND ***VIEW_OWN_UNPUBLISHED_NODES*** = 1)
OR ***BYPASS_NODE_ACCESS*** = 1
OR ***CURRENT_USER*** IN (SELECT ur.entity_id FROM {user__roles} ur WHERE ur.roles_target_id IN (:roles[]))
```

With no roles selected, the last `OR … user__roles …` clause is omitted (the rest is identical
to core's own `node_status` filter).

The `***…***` tokens are **Views query substitutions**, replaced server-side at query build time
from the current account (not from any request input):

| Token | Resolves to | Provided by |
|---|---|---|
| `***CURRENT_USER***` | `\Drupal::currentUser()->id()` | core `user` module |
| `***VIEW_OWN_UNPUBLISHED_NODES***` | `1` if current user has *view own unpublished content* | core `node` module |
| `***BYPASS_NODE_ACCESS***` | `1` if current user has *bypass node access* | core `node` module |

Net effect per viewer: **published rows are always kept**; unpublished rows are additionally
kept if the viewer is the author (with the own-unpublished permission), has bypass access, or
holds one of the selected roles. The whole OR block is added as one expression, so it is
parenthesized as a unit relative to other filters in the same group.

## What "Current user has roles" (`current_user_has_roles`) queries

`CurrentUserHasRoles::query()` adds just the role-membership test:

```sql
***CURRENT_USER*** IN (SELECT ur.entity_id FROM {user__roles} ur WHERE ur.roles_target_id IN (:roles[]))
```

This is a whole-view gate on the viewer, not a per-row test on content: if the current user
holds one of the selected roles the condition is true for every row (the view returns its normal
result); otherwise it is false for every row (the view returns nothing). Use it to show an entire
listing only to holders of certain roles, without adding a Views relationship to the author. If
no roles are selected the subquery's `IN ()` is empty and matches nothing.

## Role options offered

Both plugins share `getValueOptions()`: on Drupal ≤10 it uses `user_role_names(TRUE)` (excludes
anonymous), on Drupal 11 it replicates that by loading all roles and unsetting
`RoleInterface::ANONYMOUS_ID`; in both cases it then unsets `AccountInterface::AUTHENTICATED_ROLE`
and sorts natural/case-insensitive. So the select lists **custom roles only**.

`validate()` is a no-op when no value is chosen (so an empty filter does not error), and
`adminSummary()` shows `operator role_a role_b`.

## Configuration storage & schema

There is no settings form and no config object of the module's own. The chosen roles live inside
the **view's** display config as the filter handler's `value` (an array of role machine names).
Schema in `config/schema/views_published_or_roles.schema.yml`:

```yaml
views.filter.status_has_role:
  type: views.filter.in_operator
  label: 'Views published or roles filter'
views.filter.current_user_has_roles:
  type: views.filter.in_operator
  label: 'Views current user has roles filter'
```

In a view's exported YAML the handler sits under
`display.<id>.display_options.filters.<key>` with `plugin_id: status_has_role` (or
`current_user_has_roles`), `table: node`, `field: status`, and `value:` listing the selected
role ids, e.g.:

```yaml
value:
  editor: editor
  reviewer: reviewer
```

## Note on access

These handlers are query filters. They decide which node rows the Views query returns; Drupal's
entity view-access system still governs whether a returned node is actually shown to the viewer.
Admitting an unpublished row into the result is a listing convenience, not an access grant.
