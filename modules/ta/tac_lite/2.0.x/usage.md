<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Access Control Lite (tac_lite) grants users view/update/delete access to nodes based on the taxonomy terms the node is tagged with, combined with the user's roles and per-user assignments — using Drupal's node_access grants system.

---

You pick one or more vocabularies whose terms act as access categories (`tac_lite.settings:tac_lite_categories`), then define up to seven **schemes** (`tac_lite_schemes`), each granting a set of node operations (`grant_view`, `grant_update`, `grant_delete`) in its own node-access **realm** (`tac_lite_scheme_<n>`). For each scheme you associate roles with terms (role defaults in `tac_lite_config`/`tac_lite_grants_scheme_<n>`) and can additionally grant specific terms to individual users (stored via the user.data service, edited on the `/user/{user}/tac_lite` tab). At node save, `hook_node_access_records()` writes a grant row (gid = term id) in each scheme's realm for every tac_lite term on the node; `hook_node_grants()` returns the term ids a user may access, so a user sees/edits a node only if they hold a grant for one of its terms. Crucially the module **grants** access — it can only reveal content, so you use Drupal's core permissions to hide content first, then tac_lite to selectively show it. Terms may be identified by `tid` or `uuid` (`tac_lite_storage_type`) for portability. A scheme can also control **term visibility** (in tag clouds / edit forms, via a query alter) and optionally apply to unpublished content. Configuration lives at `/admin/config/people/tac_lite` (settings + one tab per scheme); it adds one permission (`administer tac_lite`), a `user.tac_lite_grants` cache context, and no database tables. After changing schemes you must **rebuild node access permissions**. The bundled **tac_lite_create** submodule additionally hides taxonomy term options on node add/edit forms.

---

- Make some nodes visible only to users associated with a "Private" taxonomy term.
- Give clients access to only their own project's content by tagging nodes with a project term.
- Grant a specific user extra access beyond their role via the per-user "access by taxonomy" tab.
- Grant a whole role view access to content tagged with certain terms.
- Add separate schemes for view, update, and delete so editors can change only their categories.
- Reveal otherwise-hidden (core-denied) content to selected users based on taxonomy.
- Keep unpublished content visible to authorized reviewers with the "apply to unpublished" option.
- Control who can see taxonomy terms themselves (tag clouds, term pages) via term visibility.
- Use up to seven independent access schemes, each with its own node-access realm.
- Identify access terms by UUID instead of TID so grants survive cross-environment deployment.
- Restrict a "Staff only" section of the site to the staff role by tagging its nodes.
- Model per-department content visibility with a Department vocabulary and one scheme per op.
- Let partners edit (update) content in their category while clients can only view it.
- Grant "grant id 0" fallthrough so untagged nodes remain visible to everyone.
- Hide term options a user may not use on node forms with the tac_lite_create submodule.
- Rebuild node access permissions after configuring schemes to apply grants.
- Combine role-based defaults with per-user overrides for fine-grained access.
- Provide category-based access without creating a new role for every category/role combination.
- Cache term listings per user grant set via the user.tac_lite_grants cache context.
- Restrict access on any node type that references a controlled vocabulary.
- Troubleshoot access by rebuilding permissions or temporarily disabling the module.
- Scope delete rights narrowly by granting grant_delete only in a dedicated scheme.
- Support multilingual sites by resolving term grants across languages.
