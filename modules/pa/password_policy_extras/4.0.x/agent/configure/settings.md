# Configure — settings

Source: `src/Form/PasswordPolicyExtrasSettingsForm.php`,
`config/install/password_policy_extras.settings.yml`, `config/schema/password_policy_extras.schema.yml`,
`password_policy_extras.module`, `password_policy_extras.libraries.yml`.

## Route & permission

`password_policy_extras.settings` → `/admin/config/security/password-policy/extras/settings`
(under Password Policy's admin index), permission `administer site configuration`, `_admin_route: TRUE`.

## Config object `password_policy_extras.settings`

| Key | Type | Default | Effect |
|---|---|---|---|
| `disable_ajax_progress` | bool | `true` | Removes the AJAX throbber (`#ajax['progress'] = ['type' => 'none']`) on password re-check |
| `failed_messages_only` | bool | `true` | Attaches the `failed_messages_only` library — show only failed rules instead of the full 3-column table |
| `hide_password_suggestions` | bool | `true` | Attaches `hide_password_suggestions` CSS — hides core's default password suggestion text |
| `display_status_after_pass` | bool | `true` | Passed to JS: move the status display below the main password field |
| `display_status_on_focus` | bool | `true` | Passed to JS: show the status table when the password field gains focus (also unsets the `#states` hide-when-empty behavior) |
| `status_refresh_delay` | int | `500` | Debounce in ms before the status re-checks while typing; `0` disables delayed refresh |

## How it wires into forms

- `hook_element_info_alter` swaps Password Policy's `password_confirm` `#process` callback for
  `password_policy_extras_check_constraints_password_confirm_process`, which adds an `#ajax` change
  handler (callback `_password_policy_extras_check_constraints`, wrapper `password-policy-status`) — so
  live validation works even when no user entity is in form state.
- `hook_form_user_form_alter` attaches libraries/`drupalSettings` (via
  `_password_policy_extras_add_libraries_and_settings_to_form`) and, on existing users with an empty
  password field, hides the status table by default (unless `display_status_on_focus`).
- `hook_module_implements_alter` re-orders these hooks to run after Password Policy's.

Libraries: `password_policy_extras/password_policy_extras` (JS + drupalSettings `status_refresh_delay`,
`display_status_after_pass`, `display_status_on_focus`), plus the optional `failed_messages_only` and
`hide_password_suggestions` libraries toggled by config.
