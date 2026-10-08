<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Published or Roles (views_published_or_roles) — agent index

Registers two **non-exposable** Views filter handlers on the `node` base table, via
`hook_views_data_alter()`:

- **Published or has role** (id `status_has_role`) — a row survives when the node is
  published, OR the current user is its author with *view own unpublished content*, OR the
  current user has *bypass node access*, OR the current user holds one of the roles selected on
  the filter. Lets a chosen role see unpublished nodes in a listing without granting them a
  content-editing permission.
- **Current user has roles** (id `current_user_has_roles`) — a row survives only when the
  current (logged-in) user holds one of the selected roles; otherwise the view returns nothing.
  Looks up the current user's roles without needing a Views relationship to the author.

Depends on core `views`. Core requirement `^8 || ^9 || ^10 || ^11`. No routes, no settings page
(`configure: null`), no permissions, no drush, no new plugin type. These are Views query
filters: they shape the SQL WHERE clause; the entity view-access check still governs what a
rendered node reveals.

- **Add / configure either filter in a view, the query it builds, config & schema** →
  [views/filters.md](views/filters.md)

Key facts:
- Views handler ids: `status_has_role`, `current_user_has_roles` (both attached to table `node`
  in `views_published_or_roles_views_data_alter()`, filter `field` = `status`, `no group by` = TRUE).
- In the Views UI they appear as **Content: Published or has role** and **Content: Current user
  has roles**.
- Plugin classes: `Drupal\views_published_or_roles\Plugin\views\filter\PublishedOrHasRoles`
  and `...\CurrentUserHasRoles`, both extending `FilterPluginBase`; both `canExpose() => FALSE`.
- The role selection is stored as the filter handler's `value` (array of role machine names)
  inside the view's display config; the value form is a multi-select of **custom roles only**
  (anonymous and authenticated excluded).
- Config schema: `views.filter.status_has_role` and `views.filter.current_user_has_roles`
  (both `type: views.filter.in_operator`) in `config/schema/views_published_or_roles.schema.yml`.
- Queries target `node_field_data`; the role test is a subquery against `{user__roles}`.
