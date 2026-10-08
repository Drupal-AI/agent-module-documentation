<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content View Access (info name "Bundle Access") lets an administrator map each node content-type and taxonomy vocabulary, per user role, to an action taken when that role visits the entity's canonical page: Access Denied (403), Not Found (404), redirect to Front page, or a Blank page.
---
The problem it targets is coarse "role X should not see content type Y" gating without writing code. Configuration lives at `/admin/config/people/content-view-access` (a `FormBase` that iterates roles × node types and vocabularies and stores an `access[entity_type][bundle][role] = action` matrix in `content_view_access.settings`). Enforcement is a `KernelEvents::REQUEST` subscriber (`ContentViewAccessSubscriber`, priority 32) that fires only on the `entity.node.canonical` and `entity.taxonomy_term.canonical` routes: it reads the current user's roles, looks up the matrix for the entity's bundle, and throws `AccessDeniedHttpException`/`NotFoundHttpException` or sets a redirect/empty response.

Operational and security notes: this is **not** a real access-control layer. The module does not implement `hook_node_access`, node access grants, or an entity access handler — it only intercepts two HTML canonical routes. Content "denied" here remains fully reachable through any other channel (JSON:API, REST `?_format=json`, Views listings, search, RSS, the edit/revision routes, previews). Treat it as page-level presentation/redirect control, not as protection for sensitive data. Two config issues to know: the routing requirement `_permission: 'administer content view access'` does not match the permission actually declared in `content_view_access.permissions.yml` (`administer bundle access`), so the settings form is only reachable by user 1 unless the mismatch is corrected; and the module still ships legacy empty `hook_menu`/`hook_permission` stubs. The typical setup task is: grant the admin permission, open the form, and set an action for each bundle/role pair that should be blocked or redirected.
---
- Block one role from viewing a specific content type's node pages (403).
- Return 404 for a role on a given content type instead of a 403.
- Redirect a role to the front page when they open a certain content type.
- Show a blank page to a role for a chosen content type.
- Apply the same actions to taxonomy term pages by vocabulary.
- Configure different actions for different roles on the same bundle.
- Leave a bundle/role pair as "- None -" to keep default behavior.
- Hide a "members only" content type's canonical pages from anonymous users.
- Send anonymous visitors of a vocabulary's term pages to the home page.
- Redirect authenticated users away from an internal content type.
- Set up bulk rules across many content types in one form save.
- Review the current access matrix on the settings form (open details show configured bundles).
- Combine with real access modules for actual data protection.
- Use 404 responses to avoid revealing that content exists.
- Use front-page redirects to funnel users to a landing page.
- Quickly disable a rule by resetting its select to "- None -".
- Stage bundle visibility changes without editing node permissions.
- Grant the "administer bundle access" permission to a trusted admin role.
- Adjust rules as new content types or vocabularies are added.
- Audit that blocked bundles are still protected at the data layer (JSON:API/REST/Views).
