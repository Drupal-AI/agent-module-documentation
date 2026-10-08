<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AhaSend (ahasend) — agent index

Routes Drupal's outbound email through the **AhaSend** transactional email API
(`POST https://api.ahasend.com/v1/email/send`) via a **Mail System** plugin. Package `Mail`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0. **Not** covered by a security advisory
policy. No submodules, no config schema, no Drush, no update hooks.

- **Config form, config object, routes, permission, install behavior** →
  [config/settings.md](config/settings.md)
- **The mail plugin, the send handler, payload shape, attachments** → [api/mail-send.md](api/mail-send.md)

## What it actually is

- **Dependency:** `mailsystem:mailsystem` (Mail System) — required to route selected mail keys to
  this plugin. Composer deps: `pear/mail` (`Mail_RFC822` address parser) and `html2text/html2text`.
- **Mail plugin:** `AhaSendMail` (id **`ahasend_mail`**), `src/Plugin/Mail/AhaSendMail.php`,
  implements `MailInterface` + `ContainerFactoryPluginInterface`. `format()` joins the body,
  optionally runs `check_markup()` with the configured `format_filter`; `mail()` builds the payload
  and delegates to the handler.
- **Send service:** `ahasend.mail_handler` → `Drupal\ahasend\AhaSendHandler`
  (`src/AhaSendHandler.php`). Injects `config.factory`, `logger.channel.ahasend`,
  `stream_wrapper_manager`, `entity_type.manager`, `http_client` (Guzzle). `sendMail()` assembles
  the JSON `email` object and POSTs it to the AhaSend API with the key in the `X-Api-Key` header.
- **Settings form:** `SettingsForm` (`src/Form/SettingsForm.php`) extends `ConfigFormBase`; route
  **`ahasend.settings`** at `/admin/config/mail/ahasend`, permission **`administer ahasend`**
  (`restrict access: TRUE`). Menu link `ahasend.links.menu.yml` under *Configuration → System*.
- **Config object:** `ahasend.settings` (keys: `api_key`, `from_name`, `debug_mode`;
  `format_filter` is read by the plugin but not written by the form). No `config/install/`, no
  `config/schema/`.
- **Install hooks (`ahasend.install`):** `hook_install()` adds `ahasend` to `system.mail`
  `interface`; `hook_uninstall()` removes it.
- **Hook:** `ahasend_mail()` in `.module` defines the test-run message.

## Routes / permissions / services

| Kind | Name | Detail |
|------|------|--------|
| Route | `ahasend.settings` | `/admin/config/mail/ahasend`, `_permission: administer ahasend` |
| Permission | `administer ahasend` | `restrict access: TRUE` |
| Service | `ahasend.mail_handler` | `AhaSendHandler` (send logic) |
| Service | `logger.channel.ahasend` | dedicated logger channel |
| Mail plugin | `ahasend_mail` | `AhaSendMail` |

No inbound/webhook routes — this module only **sends** mail; it does not receive delivery callbacks.
