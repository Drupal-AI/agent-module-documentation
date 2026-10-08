<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & runtime — how a notification fires

All logic lives in `user_register_notify.module` (no service class). Entry points:

| Hook | Function | Action arg |
| --- | --- | --- |
| `hook_ENTITY_TYPE_insert` (user) | `user_register_notify_user_insert()` | `create` |
| `hook_ENTITY_TYPE_update` (user) | `user_register_notify_user_update()` | `update` |
| `hook_ENTITY_TYPE_delete` (user) | `user_register_notify_user_delete()` | `delete` |

Each calls `user_register_notify_setup_email($account, $action)`.

## Send flow (`user_register_notify_setup_email`)

1. Return immediately if `type === 'disabled'` **or** `user_register_notify_check_setup_allowed()`
   is false.
2. `$from` = `system.site` `mail`. `$params = ['account' => $account]`.
3. Resolve recipients with `user_register_notify_get_mails()`. If empty, log a notice and stop.
4. `$to = implode(', ', $emails)`; send via
   `\Drupal::service('plugin.manager.mail')->mail('user_register_notify',
   'user_register_notify_' . $action, $to, $langcode, $params, $from, TRUE)` (send = TRUE).
5. If `enable_logging`, write a watchdog notice listing recipients. Exceptions are caught and
   logged as errors.

### `user_register_notify_check_setup_allowed($account, $action)` — gating

- Returns **FALSE** if `$action` is not in `events`, **or if the account is uid 1** (root is never
  notified-on).
- Picks the per-event `*_roles_mode` + `*_roles`. If no roles are selected → allowed.
- `exclude` mode: blocked when the account has any selected role. `include` mode: blocked when the
  account has none of them. (`anonymous` is stripped from the account's roles first.)

### `user_register_notify_get_mails()` — recipients

- `type: custom` → `explode(',', mail_to)`.
- `type: both` → the `mail_to` addresses **plus** the role addresses (falls through to `role`).
- `type: role` → `entityQuery('user')` for **status = 1** users whose `roles` are IN the
  configured `roles`, collecting each `->getEmail()`.

## `hook_mail` — `user_register_notify_mail($key, &$message, $params)`

Only acts on keys `user_register_notify_create` / `_update` / `_delete`. Loads the matching
`*_subject` / `*_body` config and sets `$message['subject']` / `$message['body'][]` via
`\Drupal::token()->replace($template, ['user' => $params['account']], ['language' => ...,
'callback' => 'user_mail_tokens', 'clear' => TRUE])`. Token output is intentionally not
HTML-sanitized because the target is a plain-text email (per the in-code comment); usernames go
through Drupal's mail manager, which mime-encodes headers.

## `hook_mail_alter` — `user_register_notify_mail_alter(&$message)`

For message ids listed in `mail_message_ids_header_overwrite_header`, sets `From` and/or `Reply-to`
headers from `mail_from` / `mail_reply_to`. (See configure/settings.md: a wrong config name in
2.0.0-beta2 disables this in practice.)

## Token defined — `hook_token_info` / `hook_tokens`

Registers one `user` token `[user:user-register-notify-og-groups]` — a comma/newline list of the
Organic Groups the account belongs to. Requires the contrib `og` module; if `og` is absent it
renders a placeholder string. Not present in any default template; add it to a body/subject if
wanted.
