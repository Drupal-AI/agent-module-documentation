<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Admin Notify (comment_admin_notify) — agent index

Sends a **plain-text e-mail to a configured admin address on every new comment**, for the node
content types you select. Version **2.x** (packaged 2.1.0). Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later.

- **Settings form, config keys, tokens, and the notification mechanism** →
  [config/settings.md](config/settings.md)

## What it actually is

- Two procedural hooks in `comment_admin_notify.module`:
  - `comment_admin_notify_comment_insert($comment)` — `hook_ENTITY_TYPE_insert()` for `comment`;
    builds and sends the notification.
  - `comment_admin_notify_mail($key, &$message, $params)` — `hook_mail()`; sets `subject` and
    appends `body` (plain text).
- One config form: `\Drupal\comment_admin_notify\Form\CommentAdminNotifyForm` (extends
  `ConfigFormBase`, form id `comment_admin_notify_settings_form`), editing config object
  **`comment_admin_notify.settings`**.
- **No** permissions of its own, **no** services, **no** plugins, **no** Drush, **no** entities,
  **no** config schema/install defaults on disk (all settings default in code).

## Dependencies

- Core **`comment`** and contributed **`token`** (`drupal:comment`, `token:token` in the
  `.info.yml`). Token is used to expand node/comment tokens in the subject and body templates.

## Routes & access

- `comment_admin_notify.settings` → `/admin/config/system/comment-admin-notify`, form
  `CommentAdminNotifyForm`, requirement `_permission: 'administer site configuration'`. Menu link
  under *Configuration → System* (`comment_admin_notify.links.menu.yml`).

## Mechanism (from source)

- On comment insert, if config key `comment_admin_notify` is truthy (default `TRUE`), it reads the
  commented entity's bundle; if that bundle is in `comment_admin_notify_content_types` (default =
  **all node types**, via `comment_admin_all_content_types()`), it proceeds.
- Recipient = `comment_admin_notify_mailto`, defaulting to the site e-mail
  (`comment_notify_variable_get_site_email()` → `system.site` `mail`, else `ini_get('sendmail_from')`).
- Subject (`comment_admin_notify_subject`, default *"Comment notification"*) and body
  (`comment_admin_notify_mailtext`, default template in `comment_admin_default_mailtext()`) are
  **both** run through `\Drupal::token()->replace(...)` with `comment` and (for node comments)
  `node` objects, then handed to `plugin.manager.mail`'s `mail()` under key `comment_notify_mail`.
- Every send is logged: `\Drupal::logger('comment_admin_notify')->notice(...)` with nid, cid,
  subject.
- Sent in the site default language (`languageManager()->getDefaultLanguage()`).

## Notes

- The helper `comment_notify_variable_get($key, $default)` treats an **empty** stored value as
  "unset" and falls back to the default — so a blank recipient falls back to the site e-mail, and a
  blank/`0` "Enable" value falls back to `TRUE`.
- Notification is a simple `text/plain` mail; there is no HTML formatting of the comment body.
