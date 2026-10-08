<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comments Ban (comments_ban) — agent index

Lets administrators **ban individual user accounts from posting comments** while leaving those
accounts otherwise active on the site (they can still log in and browse). Enforcement is a
server-side **validation constraint** on the comment entity, driven by a boolean field on the user.
Depends only on core **`comment`**. Package `Spam control`. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed **1.0.3**; version dir `1.0.x`. No stable-release Composer library deps,
no `.permissions.yml` (reuses core permissions), no config schema, no custom routes or controllers.

## How the ban is stored and enforced (from source)

- **Field** `field_user_banned_comments` — a boolean base-field-style configured field on the
  **user** entity (`config/install/field.storage.user.field_user_banned_comments.yml` +
  `field.field.user.user.…yml`), label "User banned from comments", default `0`. `1` = banned.
- **Enforcement** — `comments_ban.module` `hook_entity_type_alter()` adds the constraint
  `userCommentBanned` to the `comment` entity type. `Plugin/Validation/Constraint/CommentsBanConstraint`
  declares the constraint and its violation message (`You're not allowed to post this comment`).
  `CommentsBanConstraintValidator::validate()` loads the **current user** entity (via
  `entity_type.manager` in the constructor, keyed on `current_user->id()`) and adds a violation when
  `field_user_banned_comments->value` is truthy. This runs during comment entity validation, so it
  blocks the comment form submission server-side (not just cosmetic). The check is on the **posting
  session's user**, so it targets authenticated accounts; anonymous posters (uid 0) have no such
  field value and are unaffected.
- **Form guard** — `hook_form_alter()` sets `#access = FALSE` on the `field_user_banned_comments`
  widget in `user_form` unless the current user has **`administer users`**, so only user-admins see
  or edit the checkbox on a profile edit form.

## What it provides (from source)

- **Action** `ban_user_comment` (`Plugin/Action/RemoveCommentBanUserAction`, type `comment`,
  config `system.action.ban_user_comment`) — "Remove comment and ban user": sets the author's
  `field_user_banned_comments = 1`, saves the user, then deletes the comment. `access()` requires
  **`administer comments`**. Meant to be added to a comments view as a bulk operation.
- **Action** `unban_user_comment` (`Plugin/Action/UnbanUserCommentsAction`, type `user`,
  config `system.action.unban_user_comment`) — "Unban user from the comments": sets the target
  user's `field_user_banned_comments = 0` and saves. `access()` requires **`administer comments`**.
- **View** `users_banned_comments` (`config/install/views.view.users_banned_comments.yml`) — page at
  **`/admin/config/people/banned-from-comments`** (admin menu item under People), lists users where
  `field_user_banned_comments = 1`, with a user bulk form wired to the `unban_user_comment` action.
  Display access is **`perm: administer users`**.
- **Uninstall** (`comments_ban.install` `hook_uninstall()`) — deletes the two action configs, the
  view, and the `field_user_banned_comments` field storage.

## Permission model (factual)

- Editing the ban checkbox on a user profile / seeing the management view → **`administer users`**.
- Running the ban / unban bulk actions → **`administer comments`**.

Both are core restricted-access admin permissions. There are no module-defined permissions and no
custom access-callback routes.

## Setup summary

1. Enable the module (`drush en comments_ban`). Installs the field, actions and view.
2. Grant `administer users` (to manage bans via the profile field / view) and/or `administer
   comments` (to use the ban/unban bulk actions) to trusted roles.
3. The ban field is already placed on the user form by config; confirm it under **Manage form
   display** for the user entity if you don't see it.
4. Ban a user by ticking "User banned from comments" on their edit form, or via the "Remove comment
   and ban user" action on a comments view. Unban via the checkbox or the management view's bulk op.

No dedicated settings form; no runtime configuration beyond the per-user boolean.
