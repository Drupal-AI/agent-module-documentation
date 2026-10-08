<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

## Install & enable
`drush en discord_notifications`. Depends on core `node` and `user`; no external libraries or composer requirements.

## Route & access
- Route id `discord_notifications.settings`, path `/admin/config/system/discord-notifications` (`discord_notifications.routing.yml`).
- Form: `Drupal\discord_notifications\Form\DiscordNotificationsSettingsForm` (extends `ConfigFormBase`).
- Requirement: `_permission: administer site configuration` (no module-specific permission is defined).
- Menu link `discord_notifications.settings` under `system.admin_config_system` (`discord_notifications.links.menu.yml`).

## Config object: `discord_notifications.settings`
Schema: `config/schema/discord_notifications.schema.yml` (`type: config_object`). Editable name returned by `getEditableConfigNames()`.

| Key | Type | Meaning |
| --- | --- | --- |
| `webhook_url` | string | Discord incoming webhook URL. Form field is `#type => url`, `#required => TRUE`. |
| `use_here` | boolean | Prefix each message with `@here`. |
| `use_everyone` | boolean | Prefix each message with `@everyone` (only applied when `use_here` is off — the service uses `if use_here … elseif use_everyone`). |
| `content_notifications` | sequence of string | Enabled content events. |
| `user_notifications` | sequence of string | Enabled user events. |
| `system_notifications` | sequence of string | Enabled system events. |
| `security_notifications` | sequence of string | Enabled security events. |

The form renders the four lists as `#type => checkboxes`; `submitForm()` stores them via `array_filter($form_state->getValue(...))`, so only ticked keys are saved into each sequence.

## Event option keys (form → config → checked by service)
- Content (`content_notifications`): `node_create`, `node_update`, `node_delete`. The service checks `in_array("node_{$operation}", …)`.
- User (`user_notifications`): `user_register`, `user_login`, `user_blocked`. Service checks `in_array("user_{$operation}", …)`.
- System (`system_notifications`): `update_available`, `cron_run`. `hook_cron` fires `cron_run`; `update_available` is offered as an option but no hook emits it in this version.
- Security (`security_notifications`): `failed_login`, `password_reset`.

## Notes for operators
- No config ships in `config/install/`; all keys are empty/unset until the form is saved. If `webhook_url` is empty the service logs an error to the `discord_notifications` channel and sends nothing.
- The form injects `@state` but does not use it beyond construction.
- There is no test-message / "send test" button; verify by triggering a real enabled event.
