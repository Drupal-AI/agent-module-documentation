<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Messenger

Despite the name this is not user-to-user chat. It defines a `private_messenger_message` content entity that an administrator creates against a recipient user. On that recipient's next login (`hook_user_login`) the stored message is displayed with Drupal's messenger (as warning/status/error) and then deleted (unless the session is masquerading).

---

# Installing & configuring

- Enable the module (depends on core `text`).
- Manage messages under `/admin/content/private-messenger-message` (add/edit/delete/collection all use the entity admin permission `access private messenger message overview`).
- Each message has type, message text, serialized parameters, author and recipient user references.
- No front-end/user-facing routes are exposed.

---

- Entity `private_messenger_message` uses `AdminHtmlRouteProvider`; all routes require `access private messenger message overview`.
- There is no cross-user read surface: only holders of the admin permission can list/view messages.
- `hook_user_login()` loads messages where `recepient_uid` = the logging-in user and displays them.
- Messages are deleted after display unless `session` has `masquerading`.
- The message text is used as the `t()` string when displayed.
- `parameters` is stored as a serialized string and exposed in the form as a plain text field.
- The list builder query uses `accessCheck(FALSE)` (admin listing context).
- `preCreate()` sets the author uid to the current user.
- Recipient and author are entity references to users.
- The view builder strips the entity template (messages have no themed body).
- Cache max-age is 0 for the entity.
- No anonymous or authenticated-user-facing endpoints exist.
- Useful to warn a specific user (e.g. about an account action) on their next login.
