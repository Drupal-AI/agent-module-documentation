<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds one-click AJAX toggle links so editors can flip node published/promoted/sticky status and comment published status straight from listings, without opening the edit form.

---

Fasttoggle (package Administration) is a small workflow helper for Drupal 10.1+/11 that depends on core's Node and Comment modules. For each content type you can enable up to three toggles — published status, promoted-to-front-page, and sticky-at-top-of-lists — and for each comment type you can enable a published-status toggle; these are turned on per bundle in a "Fasttoggle" section added to the content-type and comment-type edit forms, and are stored as `fasttoggle` third-party settings on the node.type / comment.type config entities. Where a toggle is enabled, the module's `hook_node_links_alter` / `hook_comment_links_alter` implementations add an AJAX toggle link to that entity's operation links for users who hold the "use fasttoggle" permission. Clicking a link hits the `fasttoggle.toggle` route (`/fasttoggle/{entity_type}/{entity_id}/{action}`), which flips the value, saves the entity, and returns an AJAX ReplaceCommand that swaps the link label in place. A single site settings form (route `fasttoggle.settings`, permission "administer fasttoggle") controls the link label style: status labels that reflect the current state ("Published", "Sticky") or action labels that show what a click will do ("Unpublish", "Promote"), the latter being the default.

---

- Let editors publish or unpublish a node in one click from a content listing instead of opening the full edit form.
- Promote or demote a node to the front page directly from its operation links.
- Mark a node sticky or not-sticky at the top of lists without editing it.
- Publish or unpublish a comment in one click from a comment listing.
- Speed up moderation of a busy content queue by toggling statuses inline via AJAX.
- Enable only the toggles that fit a given content type (e.g. status but not promote/sticky) per bundle.
- Enable the comment status toggle for a specific comment type only.
- Choose "action" labels (Publish/Unpublish, Promote/Demote) so links state what a click does.
- Choose "status" labels (Published/Not published, Sticky/Not sticky) so links reflect current state.
- Give a defined editor role the "use fasttoggle" permission so it can use the quick toggles.
- Restrict configuration of the label style to admins via the "administer fasttoggle" permission.
- Reduce page loads for repetitive publish/unpublish work by using in-place AJAX replacement.
- Provide a lighter-weight alternative to opening each node's edit form for a single status change.
- Surface promote-to-front-page as a one-click action for news or blog content types.
- Surface sticky as a one-click action for announcement or forum-style content types.
- Toggle status on many items quickly while reviewing a moderation or admin content view.
- Keep the toggle affordance consistent across content and comment listings site-wide.
- Configure which node types expose fasttoggle links from Structure > Content types > [type] > Fasttoggle.
- Configure which comment types expose the status toggle from the comment-type edit form.
- Set the site-wide label style at Administration > Configuration > System > Fasttoggle.
- Roll out quick toggles to a curated set of roles by granting a single "use fasttoggle" permission.
- Turn all fasttoggle links off for a bundle by clearing its Fasttoggle checkboxes.
