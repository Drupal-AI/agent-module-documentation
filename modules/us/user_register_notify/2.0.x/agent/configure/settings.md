<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings form & config object

- Route: `user_register_notify.settings` → `/admin/config/people/user_register_notify/settings`
  (also a menu link under `user.admin_index` and a local task tab).
- Form: `Drupal\user_register_notify\Form\UserRegisterNotifyAdminSettingsForm` (extends
  `ConfigFormBase`), form id `user_register_notify_admin_settings_form`.
- Editable config: **`user_register_notify.settings`** (single config object; has schema and a
  `config_translation` mapping).
- Gated by permission `administer user_register_notify configuration`.

Out of the box the module ships `type: disabled` and empty `events` — it sends **nothing** until
you set a `type` other than `disabled` and check at least one event.

## Config keys

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `type` | string | `disabled` | Recipient mode: `disabled`, `role`, `custom`, `both`. |
| `mail_to` | string | `""` | Comma-separated recipient addresses (used by `custom`/`both`). Validated as email on save; empty entries rejected. |
| `roles` | sequence | `[]` | Role ids whose **active** members receive mail (used by `role`/`both`). |
| `events` | sequence | `[]` | Which events fire: any of `create`, `update`, `delete`. |
| `created_subject` / `created_body` | label / text | see below | Template for the `create` mail. Both required. |
| `updated_subject` / `updated_body` | label / text | see below | Template for the `update` mail. Both required. |
| `deleted_subject` / `deleted_body` | label / text | see below | Template for the `delete` mail. Both required. |
| `created_roles_mode` / `updated_roles_mode` / `deleted_roles_mode` | string | `exclude` | `include` = only fire when the affected account has one of the roles below; `exclude` = suppress when it has one of them. |
| `created_roles` / `updated_roles` / `deleted_roles` | sequence | `[]` | Role ids for the per-event include/exclude filter. Empty = no filter (fire for any account). |
| `mail_from` | string | `""` | Override "From" header (email-validated). |
| `mail_reply_to` | string | `""` | Override "Reply-to" header (email-validated). |
| `mail_message_ids_header_overwrite_header` | sequence | `[]` | Which mail message ids the From/Reply-to override applies to (this module's own ids plus a list of core `user` module mail ids — see below). |
| `enable_logging` | boolean | `FALSE` | Log a watchdog notice for each notification sent. |

The `subject`/`body` fields are validated with `token_element_validate` for the `user` token type,
and the form renders a `token_tree_link` so an admin can browse available tokens. Roles are listed
by `Role::loadMultiple()` with `anonymous` removed.

### Default templates (from `config/install`)

- `created_subject`: `New User registration "[user:name]" at [site:name] ([site:url], [current-date:short]`
- `created_body`: names the account (`[user:name]`, `[user:url]`), view/edit/cancel URLs
  (`[user:url]`, `[user:edit-url]`, `[user:cancel-url]`) and who did it
  (`[current-user:name]`, `[current-user:url]`).
- `updated_*` / `deleted_*`: same shape for the update / delete events.

Tokens are replaced with `user_mail_tokens` as callback, so core user mail tokens
(e.g. `[user:display-name]`, `[user:one-time-login-url]`, `[user:cancel-url]`) are available in
addition to the module's own `[user:user-register-notify-og-groups]`.

### From/Reply-to override — mail ids

`mail_message_ids_header_overwrite_header` may target this module's ids
(`user_register_notify_user_register_notify_create` / `_update` / `_delete`) **and** these core
`user` mail ids: `user_register_admin_created`, `user_register_no_approval_required`,
`user_register_pending_approval_admin`, `user_register_pending_approval`, `user_status_activated`,
`user_status_blocked`, `user_cancel_confirm`, `user_status_canceled`, `user_password_reset`.
Note: in **2.0.0-beta2** `hook_mail_alter()` loads the config as `user_register_notify` (missing the
`.settings` suffix), so the From/Reply-to override does not actually take effect in this release.

## Set it via Drush / PHP

```bash
# Notify a role + a custom address on create and delete, with logging.
drush cset user_register_notify.settings type both -y
drush cset user_register_notify.settings mail_to 'ops@example.com,admin@example.com' -y
drush cset user_register_notify.settings 'roles.0' administrator -y
drush cset user_register_notify.settings 'events.0' create -y
drush cset user_register_notify.settings 'events.1' delete -y
```

```php
\Drupal::configFactory()->getEditable('user_register_notify.settings')
  ->set('type', 'role')                 // disabled|role|custom|both
  ->set('roles', ['administrator'])     // active members receive the mail
  ->set('events', ['create', 'update']) // create|update|delete
  ->set('created_subject', 'New account [user:name] on [site:name]')
  ->set('created_body', "[user:name] registered.\nEdit: [user:edit-url]")
  ->set('created_roles_mode', 'exclude')
  ->set('created_roles', [])            // empty = fire for any created account
  ->set('enable_logging', TRUE)
  ->save();
```
