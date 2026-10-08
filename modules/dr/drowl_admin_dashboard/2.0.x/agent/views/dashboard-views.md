<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three shipped Views

All in `config/install/`. Each has a `default` display plus a `block` display; the page variant
embeds the block displays. Each display's `access` plugin is `perm` with a standard Drupal
permission (not `none`, not `access content`), so every block is independently gated regardless of
who reached the dashboard shell. Views config with node/user base tables goes through the normal
Views query with entity access; the Content view carries the `user.node_grants:view` cache context.

## `views.view.drowl_admin_dashboard_content` — "Content"

- Base `node_field_data`. **Access: `perm` = `access content overview`.**
- Fields: Status, Title (links to node), Type, Language, Author (via `uid` relationship), Authored
  on (created), Changed, Operations. Table style, full pager (10/page), AJAX, "» Overview" more-link
  to `/admin/content`.
- Exposed filters: Status (grouped Published/Unpublished), Title (contains), Type (bundle),
  Language. Non-exposed `status_extra` (node_status). Sorted by Changed desc by default.
- Cache contexts include `user`, `user.node_grants:view`, `user.permissions` → respects node
  access grants.

## `views.view.drowl_admin_dashboard_people` — "People"

- Base `users_field_data`. **Access: `perm` = `administer users`.**
- Fields: Status (Active/Locked), Picture (user_picture, thumbnail style), Username (links to
  user), Roles, Created, Last access, Operations. Table style, full pager (10/page), AJAX, "» Overview"
  more-link to `/admin/people`.
- Exposed filters: Username (contains), Roles. Non-exposed: `default_langcode = 1`, `uid_raw != 0`
  (excludes the anonymous user). Empty text: "No (such) user accounts."
- Config deps: `field.storage.user.user_picture`, `image.style.thumbnail`.

## `views.view.drowl_admin_dashboard_user_profile_display` — "User profile display"

- Base `users_field_data`. **Access: `perm` = `access user profiles`.** A compact card, `pager: some`
  (1 row).
- Contextual filter (argument) `uid` (`user_uid`): `default_action: not found`, validated as
  `entity:user` with `access: true`, `operation: view`. On the dashboard the page maps this to
  `@user.current_user_context:current_user`, so it shows the logged-in user's own profile.
- Fields: Picture (links to profile), Name, Email (rendered as `({{ mail }})` mailto), "User since"
  (created), Last access, edit-user links ("Edit user profile", "Change password"), and a custom
  "Logout" link to `/user/logout`. Filter `status = 1` (active users only).
- Config deps: `field.storage.user.user_picture`, `image.style.thumbnail`.
