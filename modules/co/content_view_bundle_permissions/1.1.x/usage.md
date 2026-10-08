<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content View Bundle Permissions filters the /admin/content listing per node bundle via permissions.

---

Content View Bundle Permissions defines per-node-bundle permissions (view any / view own "in content view") and uses them to filter rows in the content admin View (e.g. /admin/content) so a role only sees the bundles it is allowed to. Enforcement is via `hook_views_query_alter` plus exposed-form adjustment.

Scope note: the permission is explicitly named and described "in the content view" — it filters the Views listing only. It is NOT a general entity-access control: it does not implement `hook_node_access`/grants, so canonical node pages and JSON:API/REST are unaffected. Use it to tidy the admin listing per role, not to hide content globally. Depends on core `views` and `node`; supports Drupal 10 and 11.

---

- Add per-bundle content-view permissions.
- Filter the content admin listing by bundle.
- Provide view any / view own permissions.
- Enforce via `hook_views_query_alter`.
- Adjust the exposed filter form.
- Scope strictly to the Views listing.
- Not restrict canonical node access.
- Not affect JSON:API/REST.
- Not implement `hook_node_access`/grants.
- Tidy the admin content view per role.
- Depend on core `views` and `node`.
- Support Drupal 10 and 11.
- Name permissions "in content view".
- Show only permitted bundles in the listing.
- Support role-scoped admin lists.
- Avoid relying on it for global access control.
- Filter rows by node type.
- Improve admin listing UX.
