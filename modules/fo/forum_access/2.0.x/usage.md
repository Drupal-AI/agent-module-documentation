<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forum Access adds per-forum access control to Drupal's core Forum: for each forum you pick which roles may view, post, edit and delete, and you name a list of moderator users — turning an all-or-nothing forum area into boards where different groups see different content.

---

Core Forum has no per-forum access model — if you can see forums, you can see all of them. Forum Access supplies one, keyed on the forum taxonomy term. Per-role grants (View / Post / Edit / Delete) are stored in a custom `{forum_access}` table and applied through Drupal's node-access-grants system under the realm `forum_access`; a small config map (`forum_access.settings:forum_access_roles_gids`) translates each role machine name into the integer grant id the grants system needs. Per-forum **moderator users** are stored with the required **ACL** module (`name='moderate'`, keyed on the forum tid) and receive every grant on that forum. There is no separate settings page: an **Access control** section is injected into the core forum/container edit forms (`configure: forum.overview`), rendered as a roles × grants checkbox grid, and gated by core's `administer forums` permission. Enforcement runs on two layers — grant records for listing queries plus dynamic `hook_node_access`/`hook_ENTITY_TYPE_access` checks and route-access overrides for direct access — and grants combine with OR across any other node-access modules. Requires `drupal/acl ^2.0` and the `forum` module (install `drupal/forum` separately on Drupal 11+, where Forum left core), PHP 8.1+, core `^10.3 || ^11 || ^12`. The experimental `forum_access_migrate` submodule brings D7 settings across.

---

- Make a forum visible only to certain roles.
- Give a forum its own moderators (per-forum admins).
- Run a staff-only board alongside public forums.
- Let a members' area have private discussion.
- Restrict who may post (create topics/replies) per forum.
- Allow reading but not posting in an announcements forum.
- Delegate moderation of one forum without site-wide permissions.
- Support a paid-membership discussion area.
- Hide an archive forum from general users.
- Set per-forum access from the core Forum overview screen.
- Grant a single named user access to one private forum.
- Give a working group its own private board.
- Control which roles may edit or delete posts in a forum.
- Let moderators see and manage unpublished forum posts and comments.
- Combine forum access with ACL-based per-user moderation.
- Run support forums separated by customer tier.
- Keep a forum public by default and lock it down later.
- Rebuild node access permissions after changing forum grants.
- Restrict a container so its child forums appear only to the right roles.
- Migrate forum access settings from a Drupal 7 site.
- Build a tiered community with different visibility per board.
- Prepare a forum site for Drupal 12.
