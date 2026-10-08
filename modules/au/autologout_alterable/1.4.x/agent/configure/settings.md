# Autologout Alterable — configuration

Config UI: `/admin/config/people/autologout_alterable` (route `autologout_alterable.settings_form`,
form `AutologoutSettingsForm`, permission `administer autologout_alterable`). Config object
`autologout_alterable.settings` (schema in `config/schema/autologout_alterable.schema.yml`;
config-translatable via `autologout_alterable.config_translation.yml`).

## Core timeout keys (`autologout_alterable.settings`)
| Key | Default | Meaning |
|---|---|---|
| `enabled` | true | Master on/off. |
| `session_timeout` | 1800 | Inactivity timeout in seconds (base). |
| `max_session_timeout` | 172800 | Max a per-user threshold may be set to (on the user form). |
| `max_session_length` | null | Hard cap after which the session cannot be extended. |
| `ignore_user_activity` | false | Log out at timeout regardless of activity. |
| `use_individual_logout_threshold` | false | Enable per-user thresholds (user-form field). |
| `use_infinite_session_for_privileged` | false | Give holders of the "infinite session" permission an unlimited session. |
| `include_destination` | true | Append `destination` to the post-logout redirect. |
| `role_logout` | false | Enable per-role timeouts (`autologout_alterable.role.*`). |
| `role_logout_max` | false | When multiple roles apply, use the highest role timeout. |
| `use_cron` | true | Let cron + queue worker expire sessions server-side. |
| `use_watchdog` | true | Log autologout events to watchdog/dblog. |
| `allowlisted_ip_addresses` | '' | Comma-separated IPs exempt from autologout. |

## Client-activity keys (details group)
`client_activity_mousemove`, `client_activity_touchmove`, `client_activity_click`,
`client_activity_keydown`, `client_activity_scroll` (all bool, default true) — which browser
interactions the JS counts as activity.

## Dialog keys
`show_dialog` (true), `dialog_limit` (60 — seconds before expiry to show it), `dialog_width` (450),
`countdown_format` (`%hours%:%mins%:%secs%`; tokens `%days% %hours% %mins% %secs%`), and the string
sets: `dialog_title`, `dialog_message`, `dialog_stay_button`, `dialog_logout_button`,
the *not-extendible* variants (`dialog_title_not_extendible`, `dialog_message_not_extendible`,
`dialog_close_button_not_extendible`, `dialog_logout_button_not_extendible`), the *logged-out* dialog
(`logged_out_dialog_title`, `logged_out_dialog_message`), and the message strings
`inactivity_message` / `inactivity_message_type` and `induced_logout_message` /
`induced_logout_message_type` (message type e.g. `status`/`warning`).

## Role timeouts (`autologout_alterable.role.<role_id>`)
Per-role config object: `enabled` (bool), `session_timeout` (int). Used when `role_logout` is on;
`role_logout_max` picks the highest applicable value.

## Per-user threshold
When `use_individual_logout_threshold` is on, `autologout_alterable_form_user_form_alter` adds a
"Your current logout threshold" field to the user edit form (`AutologoutHooks::formUserFormAlter`).
It is editable when the current user has `change own autologout_alterable threshold` and is editing
their own account, or has `administer autologout_alterable`. The value is stored in `user.data`
(module `autologout_alterable`) and validated against `max_session_timeout`.

## Drush
No Drush commands. Set values with `drush config:set autologout_alterable.settings <key> <value>`.

## Update hooks (`.install`)
`update_10001` seeds the `client_activity_*` defaults; `update_11001` seeds `use_cron`;
`update_11002` renames the old `whitelisted_ip_addresses` key to `allowlisted_ip_addresses`.
