<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings

UI: `/admin/config/people/password_policy` (route
`simple_password_policy.simple_password_policy_settings`, perm `administer password policy`).
Config object: **`simple_password_policy.settings`** (edit with `drush cset simple_password_policy.settings <key> <value>`).
All rule keys are **strings**; an **empty string skips** that check.

## Rule keys (config object `simple_password_policy.settings`)

| Key | Default | Meaning |
|---|---|---|
| `min_length` | `12` | Minimum characters. Empty = skip. |
| `min_lowercase` | `1` | Min lowercase `a-z`. `0` = **must not contain** any. Empty = skip. |
| `min_uppercase` | `1` | Min uppercase `A-Z`. `0` = must not contain. Empty = skip. |
| `min_numeric` | `1` | Min digits `0-9`. `0` = must not contain. Empty = skip. |
| `min_special` | `1` | Min non-alphanumeric chars. `0` = must not contain. Empty = skip. |
| `similar_username` | `''` | Upper similarity threshold %, 0–100 (via `similar_text`). `0` = may not equal username, `100` = anything allowed. Empty = skip. |
| `min_old` | `''` | How many previous passwords may be re-used (history). `0` = never re-use. Empty = skip. Requires the `user_pass` history table (installed). |
| `min_old_age` | `''` | Only count history entries newer than this many **seconds** (window for `min_old`). Empty = all history. |
| `expire_period` | `'1 year'` | Passwords expire after this. Integer seconds, or a `strtotime` phrase (`3 months`). Empty = never expire. |
| `expire_warning` | `'3 weeks'` | Warn this far before expiry. Seconds or `strtotime` phrase. Empty = no warning. |
| `expire_warning_mail` | subject/body/from | Warning email (`hook_mail`); body supports tokens incl. `[password_policy:expire_period]`. |
| `ignore_routes` | list (see below) | Route names where the **expiry redirect** is not applied. |
| `ignore_users` | `{ }` | Usernames/emails exempt from the whole policy (matched exactly). |
| `disable_password_reset` | `0` | When true, sets `_access: FALSE` on core `user.pass` route (no reset link). |
| `force_password_reset` | (checkbox) | On save, batch-expires **all** users' passwords. Not stored in default config/schema. |
| `force_logout` | (checkbox) | On save, deletes all sessions (force re-login). Not stored in default config/schema. |

Default `ignore_routes`: `entity.user.edit_form`, `system.ajax`, `user.logout`,
`admin_toolbar_tools.flush`, `user.pass`, `image.style_public`. The service always additionally
ignores `system.css_asset`, `system.js_asset`.

## How the rules are enforced

- **User form (register + profile edit):** a `#validate` handler (`hook_form_user_form_alter`)
  calls the policy and `setErrorByName('pass', …)` — non-compliant input is **rejected before save**.
  The rules are also rendered inline under the password field (AJAX-updated on blur / role change).
- **Programmatic saves & Drush `user:password`/`upwd`:** the module overrides core's `password`
  field-type plugin (`hook_field_info_alter`); its `preSave()` validates before hashing and records a
  `policy` boolean. `hook_user_insert`/`hook_user_update` then store the new password with a
  `changed` timestamp of `0` (**expired**) when non-compliant. These paths are **not** hard-blocked.
- **Expiry redirect:** a `KernelEvents::REQUEST` subscriber loads the current user and, if
  `applyPolicy()` is true and the password is expired, dispatches an expiration event whose response
  redirects the user to their edit form; otherwise it may issue a warning. Skipped for AJAX requests
  and `ignore_routes`.
- **Generated passwords:** the `password_generator` core service is **decorated** so
  `generate()` loops until it produces a value satisfying the policy (forced to `min_length`).

## Bypass / exemption

- Role permission **`bypass password policy`** — users with it are fully exempt (see
  `permissions/permissions.md`). Note: bypassing means *their own* password isn't checked; it does
  **not** let them create other users with non-policy passwords unless those users also have a
  bypass role.
- `ignore_users` — exact username or email match.
- `ignore_routes` — suppresses only the expiry redirect on those routes.

## Install-time effects

- Creates the `user_pass` table (history) and seeds it for existing users (batch).
- Sets core `user.settings:password_strength` to `FALSE` (its meter is replaced). Uninstall restores
  it and drops the table.

Notes / gotchas: `expire_warning_mail.from` empty = site default. Config translation is supported
(`simple_password_policy.settings`). The settings-form submit splits `ignore_routes`/`ignore_users`
on a literal `\n` token rather than a real newline, so multi-line textarea entries may not split as
expected — set one value or verify after saving.
