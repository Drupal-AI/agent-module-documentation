<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hide Non-Editable Content narrows the admin Content view (`/admin/content`) so each user sees only the nodes they can edit or delete.
---
The module targets the core `content` view. Two hook services do the work. `ViewsQueryAlter` (on `hook_views_query_alter`) inspects the current user's node permissions per bundle: users with `bypass node access`, `administer nodes`, `edit any` or `delete any` for a bundle see it unrestricted; users with only `edit own`/`delete own` get a `node_field_data.uid = <current user>` condition; users with none of these get a `node_field_data.type != <bundle>` condition, removing that bundle entirely. `FormViewsExposedFormAlter` (on `hook_form_views_exposed_form_alter`) correspondingly removes non-editable bundles from the exposed Type filter options.

This is server-side enforcement: the restriction is applied to the Views SQL query, not in JavaScript, so hidden rows never reach the response. It only ever **removes** rows/options — it never adds access — so it cannot over-expose content (a user who already reaches `/admin/content` still needs the usual permissions). Note it is a convenience/UX filter scoped to the view named `content`; it is not a general node-access mechanism and does not affect other views, REST, or direct node URLs. There is no configuration — enabling the module is the whole setup.

Setup: enable the module; it applies automatically to the standard Content admin view.
---
- Show editors only the content they can actually edit.
- Hide bundles a user cannot edit from `/admin/content`.
- Scope the admin Content list by per-bundle edit/delete permissions.
- Limit the exposed Type filter to editable content types.
- Let "edit own" users see only their own nodes in the overview.
- Keep "edit any"/"delete any" users' full view intact.
- Leave admins (`administer nodes`, `bypass node access`) unrestricted.
- Reduce clutter for role-limited editors.
- Enforce the filter in the SQL query (server-side, not JS).
- Avoid exposing other authors' unmanageable content in the list.
- Apply with zero configuration.
- Improve editorial UX on multi-role sites.
- Combine with node access modules for consistent listings.
- Prevent confusion from listing non-editable rows.
- Tidy the Content overview for content-team workflows.
- Restrict the type facet to relevant bundles per user.
