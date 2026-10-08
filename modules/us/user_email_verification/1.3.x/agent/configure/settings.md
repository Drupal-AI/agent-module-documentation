# Configuration

## Required core setup (this is not optional)

The module only works if core registration is changed so users are logged in at registration and the
verification link is emailed:

1. `admin/config/people/accounts` → *Registration and cancellation*:
   - "Who can register accounts?" = **Visitors**.
   - **Uncheck** "Require email verification when a visitor creates an account" (otherwise core, not
     this module, handles verification and the user is not logged in immediately).
2. Same page → *Emails* → "Welcome (no approval required)": add the token **`[user:verify-email]`**
   (needs the Token module) to include the verification link. For the extended period use
   `[user:verify-email-extended]`.

## Module settings — `/admin/config/people/user-email-verification`

Route `user_email_verification.settings_form`, permission `manage user email verification settings`
(restricted). Config object `user_email_verification.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `skip_roles` | sequence | `{}` | Roles exempt from verification. |
| `no_creation_auto_verify` | bool | `false` | If true, do **not** auto-verify on account creation paths that allow it. |
| `no_unblock_auto_verify` | bool | `false` | If true, an admin activating a blocked user does **not** auto-verify that user's email. |
| `validate_interval` | int (s) | `604800` (7 d) | Time to verify before the account is blocked. |
| `num_reminders` | int | `0` | How many reminder mails to send during the interval. |
| `mail_subject` | label | `[site:name]: Email verification` | Reminder/verification mail subject. |
| `mail_body` | text | contains `[user:verify-email]` | Reminder/verification mail body. |
| `extended_enable` | bool | `false` | Enable the extended grace period after blocking. |
| `extended_validate_interval` | int (s) | `1209600` (14 d) | Extended window to verify and unblock. |
| `extended_mail_subject` | label | `[site:name]: Account blocked, please verify Email address` | Extended mail subject. |
| `extended_mail_body` | text | contains `[user:verify-email-extended]` | Extended mail body. |
| `extended_end_delete_account` | bool | `true` | When the extended window ends: delete the account (true) or leave blocked (false). Actual delete-vs-block also honours core's "When cancelling a user account" setting. |

Set from Drush, e.g. `drush cset user_email_verification.settings validate_interval 86400`.

Enable Configuration Translation to translate the mail subjects/bodies (a *Translate user email
verification* tab appears on the settings page).

## How enforcement runs

- **On registration** a verification record is created (`hook_user_insert`).
- **`hook_cron`** (`cronHandler()`): sends due reminders (up to `num_reminders`), then blocks accounts
  whose `validate_interval` has passed, then (if `extended_enable`) processes the extended window and
  deletes/keeps-blocked per `extended_end_delete_account`. Work is chunked through queue workers
  `user_email_verification_block_account`, `…_reminders`, `…_delete_account` (limit 10 each).
- **Verification** happens when the user clicks the emailed link (see
  [api/service.md](../api/service.md) for the route/HMAC details). `/user/user-email-verification`
  (anonymous) lets a user request a fresh link.

Install note: `hook_install` seeds every existing user (uid > 0) as already `verified` /
`STATE_APPROVED`, so turning the module on does not lock out current accounts.
