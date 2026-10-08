# Configure email-as-username & display override

## Where to configure

No dedicated form. Settings are injected into the core **Account settings** form:
`entity.user.admin_form` → `/admin/config/people/accounts` (inside the parent module's
"Email Registration" details section, added by `hook_form_user_admin_settings_alter`).

Enabling this submodule also **forces** `email_registration.settings.login_with_username = false`
(on install) and disables that checkbox — logging in with a separate username is meaningless when
the username *is* the email.

## Settings — config object `email_registration_username.settings`

| Key | Default | Meaning |
|---|---|---|
| `username_display_override_mode` | `disabled` | How the public display name is rendered. `disabled` = show the username (= the email, higher disclosure risk); `email_registration` = show only the part before `@`; `custom` = replace with `username_display_custom`. |
| `username_display_custom` | `*******` | Static text or **tokens** (user token type) used when mode is `custom`, e.g. `****` or `[user:field_full_name]`. |

```
drush cset email_registration_username.settings username_display_override_mode email_registration
drush cset email_registration_username.settings username_display_custom '****'
```

Schema: `config/schema/email_registration_username.schema.yml`. The override is applied at render
time via `hook_user_format_name_alter()` and is **skipped entirely for viewers who hold the core
"view user email addresses" permission** (they always see the real name).

## Bulk action swap

This module implements `hook_action_info_alter()` to replace the parent module's
`email_registration_update_username` action class with `UpdateUsernameWithMailAction`. So the
"Update username (from email_registration)" action on the **People** view (`/admin/people`) now
sets each selected user's username to their **full email address** and re-saves.

## Security note

Storing the email as the username can leak email addresses. The display-override setting mitigates
(but does not eliminate) this; see the module's `README.md`.
