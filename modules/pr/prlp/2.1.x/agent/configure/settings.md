<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PRLP settings

Config object `prlp.settings`, form at **`/admin/config/people/accounts/prlp`**
(route `prlp.prlp_admin_settings`, permission `administer prlp settings`, menu under
*Configuration → People → Account settings*). No configuration is required to use the module —
these just tune it.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `password_required` | boolean | `true` | Whether the "Set New Password" field on the reset landing page is **required**. Off = users may just log in without changing their password. |
| `login_destination` | string (path) | `/user/%user/edit` | Where the user is redirected after logging in via the reset link. |

## `login_destination` tokens

- `%user` → replaced with the current user's **uid** (e.g. `/user/%user/edit` → `/user/42/edit`).
- `%front` → replaced with the site front page path (`system.site` → `page.front`).
- The value is treated as an internal path; a leading `/` is added if missing. If it can't be
  resolved, PRLP logs `PRLP Invalid login destination: …` and falls back to the default, then to
  the user page.

## Read / set

```bash
drush cget prlp.settings
```
```php
\Drupal::configFactory()->getEditable('prlp.settings')
  ->set('password_required', FALSE)          // make the new-password field optional
  ->set('login_destination', '/user/%user')  // land on the account canonical page
  ->save();
```

The form (`AdminSettingsForm`, a `ConfigFormBase`) exposes exactly these two fields:
"Password Entry Required" (checkbox) and "Login Destination" (textfield).
