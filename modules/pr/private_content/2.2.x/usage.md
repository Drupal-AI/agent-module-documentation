<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Private Content lets users flag individual nodes as "private" so that only users with the right permission (plus the author) can view or edit them; it hides private nodes from everyone else, including in listings.

---

The module adds a revisionable `private` base field to every node (a custom `private` field type storing a boolean `stored` value plus a computed `value`). A per-content-type third-party setting (`node.type.*.third_party.private_content.private`) controls the field's behaviour with four modes: Disabled (always public), Enabled (public by default), Enabled (private by default) and Hidden (always private). Access is enforced two ways, deliberately: `hook_node_access()` returns `AccessResult::forbidden()` to remove view/update/delete on private nodes for users lacking permission (this handles the canonical node page and edit/delete), while `hook_node_grants()` / `hook_node_access_records()` implement the Node Access Grants API for bulk "node listing" queries (Views, the front page, search) that `hook_node_access` does not cover. Two grant realms are used: `private_view` (gid 1, granted to anyone with "access private content") and `private_author` (gid = the author's uid, so authors always see their own private nodes). Three permissions gate everything — "Mark content as private" (who may set the flag on the widget), "Edit private content" (update/delete a private node you don't own) and "Access private content" (view any private node). Crucially the module **never grants extra access** — it only removes it — and the private flag has no effect for a node's own author. Because it enables Drupal's node-grants machinery, turning it on (or changing a content type's privacy mode) requires a node access permissions rebuild, and there can be a small performance cost from the extra access checks. It ships bulk actions "Make selected content private/public" and Drupal 6 migration templates.

---

- Let authenticated users mark their own blog posts or pages as private so anonymous visitors can't see them.
- Hide sensitive nodes from search results, the front page and Views listings, not just their canonical page.
- Give a "members only" role the "Access private content" permission to read all private nodes.
- Make an entire content type always-private (e.g. an "Internal memo" type) via the Hidden privacy mode.
- Default a content type to private-on-creation while still letting editors publish it publicly.
- Allow a content type to be marked private but default to public (the standard "Enabled" mode).
- Disable the private option entirely for public-only content types (e.g. "Landing page").
- Let authors always see and edit their own private nodes regardless of the view permission.
- Grant a trusted editor role "Edit private content" so they can moderate others' private posts.
- Restrict who can even toggle the private flag using the "Mark content as private" permission.
- Bulk-mark a selection of nodes private from the content admin view using the provided action.
- Bulk-revert nodes back to public with the "Make selected content public" action.
- Keep draft/unpublished-style private notes hidden from the public without a full workflow module.
- Provide simple per-node privacy without configuring the complex Group or Domain Access modules.
- Show a "Private/Public" indicator on a node by placing the private field's formatter in the display.
- Add the private checkbox into the node form's "options" group next to Published/Promoted.
- Enforce that private content is never exposed through node-listing queries handled by node grants.
- Combine with roles so only staff (with the permission) browse an internal knowledge base of private nodes.
- Migrate legacy Drupal 6 "private" node data into Drupal 10/11 using the bundled migration templates.
- Rebuild node access grants after enabling to apply privacy rules to all existing content.
- Let each author maintain a set of personal private drafts visible only to themselves and admins.
- Protect nodes so that even with a direct URL, unauthorised users get access-denied.
- Apply privacy selectively per content type while leaving other types completely public.
- Present editors a clear four-option privacy policy per content type on the node-type form.
