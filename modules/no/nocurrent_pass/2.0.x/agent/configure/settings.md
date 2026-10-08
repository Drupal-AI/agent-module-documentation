<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure "No Current Password"

The module has exactly one setting. It controls whether the core **Current password** field is
required when editing a user account.

## The setting

- Config object: `nocurrent_pass.settings`
- Key: `nocurrent_pass_disabled` (boolean)
- **Install default: `TRUE`** — shipped in `config/install/nocurrent_pass.settings.yml`, so once
  the module is enabled the current-password requirement is *removed* by default.

Meaning:
- `TRUE`  → do **not** require current password (field hidden, validation skipped).
- `FALSE` → behave like core (current password required to change email/password).

## Via the UI

Configure route `entity.user.admin_form` → **Configuration → People → Account settings**
(`/admin/config/people/accounts`). The module injects a **"Require Current Password"** fieldset
with a checkbox **"Do not require current password"**. Tick it to disable the requirement
(sets `nocurrent_pass_disabled = TRUE`); untick to restore core behavior. Save.

## Via drush

```bash
# read
drush cget nocurrent_pass.settings nocurrent_pass_disabled

# disable the requirement (hide current password)
drush cset nocurrent_pass.settings nocurrent_pass_disabled true -y

# restore core behavior (require current password)
drush cset nocurrent_pass.settings nocurrent_pass_disabled false -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('nocurrent_pass.settings')
  ->set('nocurrent_pass_disabled', TRUE)->save();
```

## What the flag actually does

`nocurrent_pass_form_alter()` runs on the `user_form` (`user/{uid}/edit`) and `change_pwd_form`
(`user/{uid}/change-password`). When `nocurrent_pass_disabled` is TRUE it, for every account
**except user 1**:

- sets `$form_state->set('user_pass_reset', 1)` — this is core's flag that turns off the
  current-password validation, and
- sets `$form['account']['current_pass']['#access'] = FALSE` — hides the field.

User 1 (superadmin) always keeps the current-password field regardless of the setting. The
module only touches the editing form; stored account data and password hashing are unchanged.

## Notes

- No permission gates this; the account settings form is admin-only as usual
  (`administer account settings`).
- `provides_config_schema: true` — the flag is schema-validated as
  `nocurrent_pass.settings:nocurrent_pass_disabled` (boolean).
- To ship the value across environments, export/commit `nocurrent_pass.settings`.
