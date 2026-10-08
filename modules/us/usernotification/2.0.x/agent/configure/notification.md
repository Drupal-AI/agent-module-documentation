<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Send User Notification — configuration

## Settings form
- Route `usernotification.notification_settings` → `/admin/config/people/accounts/notification-setting`.
- Requirement: permission `administer account settings` (core).
- Menu link under the User admin index (`user.admin_index`).
- Form class: `Drupal\usernotification\Form\NotificationSettingsForm`.

## Config object `usernotification.settings`

| Key | Type | Required | Meaning |
|---|---|---|---|
| `subject` | text | yes | Email subject template |
| `message` | text (15-row textarea) | yes | Email body template |

- No `config/install` default ships, so `usernotification.settings` does not exist until the form is saved once; the action's email is empty until then.
- The form embeds a `token_tree_link` for token types `user` and `site` (`#show_restricted => TRUE`, `#global_types => FALSE`).
- Both fields are token-replaced at send time (see `../api/action-and-mail.md`).

## How a notification is sent
1. Save the subject and body on the settings form.
2. Go to `/admin/people`, select one or more accounts.
3. Choose **Send notification message to user(s)** in the Actions dropdown and Apply.
4. Each selected account whose email the operator may send to receives the token-personalized message.

There is no per-send composition, scheduling, or on-site display — the stored template is the single source, applied to every selected user.

## Config schema note
`config/schema/usernotification.schema.yml` defines only `action.configuration.usernotification_action` (an empty mapping for the action instance). It does **not** define a schema for `usernotification.settings`; the `subject`/`message` keys are unschemaed.
