<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Published or Roles adds two non-exposable Views filters on nodes: "Published or has role" keeps published content plus unpublished content the current user may see (as author, via bypass access, or by holding a selected role), and "Current user has roles" shows a listing only to holders of selected roles.

---

The requirement is common and awkward in Views: a single listing that shows published content to everyone yet also surfaces unpublished items to editors or reviewers, without giving that role a broad content-editing permission. Views' status filter is a single value and combining a status condition with a role condition across an OR boundary is not something the filter-group UI does cleanly, so sites end up rendering two views together (which breaks paging and sorting) or writing a bespoke `hook_views_query_alter()`. This module supplies the condition as filter plugins registered through `hook_views_data_alter()` on the `node` table: `status_has_role` (Content: Published or has role) OR-combines the core published/own-unpublished/bypass logic with a subquery testing whether the current user holds one of the roles configured on the filter, and `current_user_has_roles` (Content: Current user has roles) gates the whole view on the current user's roles when you need that check without a Views relationship to the author. Both are configured by the view builder — they cannot be exposed to visitors — and their selected roles are stored in the view's own config (schema type `views.filter.in_operator`). It depends on core `views` alone and spans `^8 || ^9 || ^10 || ^11`. Being Views filters, they shape the query; Drupal's entity view-access system still decides what a returned node actually reveals, so the filter is a listing convenience layered on top of normal access.

---

- Show editors their unpublished drafts in a listing alongside live content.
- List published content to everyone while a review role also sees pending items.
- Let a chosen role see unpublished nodes without granting content-edit permissions.
- Avoid rendering two views together to mix published and unpublished rows.
- Keep paging and sorting correct across mixed published/unpublished content.
- Build an editorial or moderation dashboard listing pending nodes.
- Show authors their own unpublished work via the own-unpublished branch.
- Give a reviewer role visibility of drafts for a workflow.
- Combine published status and role membership in a single filter.
- Replace a bespoke `hook_views_query_alter()` with a configured filter.
- Pair with View Unpublished so one role previews unpublished nodes.
- Restrict an entire view to holders of specific roles (current_user_has_roles).
- Show a "staff only" listing gated on the viewer's roles.
- Look up the current user's roles without a Views relationship to the author.
- Let bypass-node-access holders see everything through the same view.
- Keep a single view serving two audiences at different visibility levels.
- Preview scheduled or draft content for editors before publication.
- Reduce duplicated view configurations for published vs unpublished.
- Support a review workflow's inbox of items awaiting approval.
- Support a site still on Drupal 8 through 11 with one filter.
