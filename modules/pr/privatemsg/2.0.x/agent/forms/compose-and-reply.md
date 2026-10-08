<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forms: compose, reply, recipient resolution

## `PrivatemsgMessageForm` — `src/Form/PrivatemsgMessageForm.php`

A `ContentEntityForm` for `privatemsg_message` used on two routes:

- **Compose** (`entity.privatemsg_message.add`, `/messages/new/{user}`): adds a `thread_members`
  recipient autocomplete (`privatemsg_autocomplete` element, selection handler
  `default:privatemsg`) and a `thread_subject` textfield. If the URL carries a `{user}` and that
  user has messaging disabled, throws 404. On save it creates one message, then one thread row per
  recipient (plus the sender if not already present) sharing a fresh `group`, and redirects to the
  sender's thread row. If no subject is given, one is derived from `strip_tags()` of the first 30
  chars of the body.
- **Reply** (embedded on `entity.privatemsg_thread.canonical`): validates recipients aren't blocked
  (for 1:1 threads), then appends the new message to every thread row in the group and bumps
  `updated_custom`.

If the acting user has messaging disabled (`user.data privatemsg/enable` falsy), `buildForm()`
throws `NotFoundHttpException`.

### Email notification
After a successful send, for each member other than the author whose `privatemsg/notify` flag is
set, it mails a link to that member's own thread row (`hook_mail` key `privatemsg`).

## Recipient / role resolution — `src/Element/PrivatemsgAutocomplete.php`

`PrivatemsgAutocomplete extends EntityAutocomplete`. Its `validateEntityIdAutocomplete()` parses the
submitted text:

- Plain `Label (uid)` entries → `target_id = uid`.
- An entry ending `(role)` → the role is loaded by label and **every user in that role** is expanded
  into recipients.
- With `#validate_reference` (default TRUE), resolved ids are checked via the selection handler's
  `validateReferenceableEntities()`, and each resolved user is checked with `isUserBlocked(current,
  user)` — a block sets a form error. Non-existent ids produce an error.

The matching suggestions come from `PrivatemsgAutocompleteMatcher` (see plugins doc), which filters
out blocked users, messaging-disabled users, and the current user, and only suggests roles present
in the `allowed_roles` config. **Important:** the `allowed_roles` restriction and the "messaging
enabled" check are applied to autocomplete *suggestions*, not enforced in the element's
server-side validation — see the security review for the role-restriction bypass.

## Blocking forms

- `PrivatemsgBlockUserForm` (`/messages/blocked`) — a `privatemsg_autocomplete` with the
  `default:privatemsg_blocked` handler plus a table of currently-blocked users. On submit it blocks
  each chosen user if not already blocked and `canBeBlocked()` (honours `unblockable_roles`).
- `PrivatemsgAddTagForm` — AJAX form embedded on a thread (when the user has
  `privatemsg change thread tags`) to set the thread's personal `tags`; tag names are rendered with
  `Html::escape()`.

## Settings forms

- `PrivatemsgSettingsForm` (`privatemsg.settings`) — `remove_after` (days, min 1), `allowed_roles`,
  `moderator_role`, `unblockable_roles`.
- `PrivatemsgMessageSettingsForm` / `PrivatemsgThreadSettingsForm` — field-UI bundle settings stubs.
