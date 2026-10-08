# Permissions

Defined in `restrict_password_change.permissions.yml`. All enforcement is in
`restrict_password_change.module` (form alter + mail alter). None are granted by default.

| Permission | `restrict access` | Gates (when editing **another** user, unless noted) |
|---|---|---|
| `change other users password` | true | Without it, the password widget (`account.pass`) is hidden. |
| `change own password` | false | Editing **own** account: without it, `account.pass` and `account.current_pass` are hidden (user cannot change their own password). |
| `reset password by request link` | false | Without it on the recipient account, the `user_password_reset` mail is cancelled in `hook_mail_alter` — password recovery blocked. |
| `change other users username` | true | Without it, `account.name` is hidden and replaced by a disabled read-only copy (`name_setting`). |
| `change other users email` | true | Without it, `account.mail` is hidden and replaced by a disabled read-only copy (`mail_setting`). |
| `delete other users` | true | Without it, the Delete action (`actions.delete`) is removed. |
| `block other users` | (typo: `restrict acess`) | Without it, `account.status` (block/unblock) is hidden. |

## Behavior notes

- The alter compares `\Drupal::currentUser()->id()` to the edited account id; the "own
  account" branch only removes the password fields.
- Removal uses `#access = FALSE`. In Drupal Form API an inaccessible element's submitted input
  is ignored (default value kept), so a restricted admin cannot re-add a hidden field by
  crafting a POST — enforcement holds on save.
- Typical grant: a delegated "user manager" role gets core `administer users` plus only the
  specific `change *` permissions it should have; withhold the rest.

## Known defect

- `block other users` has a typo in its metadata key: `restrict acess: true` (missing "c").
  The permission still works (the status field is hidden when it is absent), but because the
  `restrict access` flag is misspelled, Drupal does not show the "this permission has security
  implications" warning next to it on the permissions page. Cosmetic/metadata bug, not an
  access bypass.
