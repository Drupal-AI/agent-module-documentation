<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AhaSend — configuration, routes, install

## Install & enable

- Requires the **Mail System** module (`mailsystem:mailsystem`) and the Composer libs
  `pear/mail` + `html2text/html2text` (declared in `composer.json`; install with
  `composer require drupal/ahasend`).
- On enable, `ahasend_install()` (`ahasend.install`) registers the mailer by adding
  `ahasend => ahasend` to the core `system.mail` `interface` map. `ahasend_uninstall()` removes it.
- To actually route mail, use **Mail System** (`/admin/config/system/mailsystem`) to set AhaSend
  (`ahasend_mail`) as the formatter/sender for the default interface or for specific modules/keys.

## Settings form

- Class: `Drupal\ahasend\Form\SettingsForm` (extends `ConfigFormBase`), route
  **`ahasend.settings`** → path `/admin/config/mail/ahasend`, title *"AhaSend settings"*.
- Guarded by permission **`administer ahasend`** (`ahasend.permissions.yml`,
  `restrict access: TRUE`). Menu link defined in `ahasend.links.menu.yml`
  (`parent: system.admin_config_system`, weight -20).
- Fields (see `buildForm()`):
  - **`api_key`** (textfield, required) — the AhaSend API key/token.
  - **`from_name`** (textfield) — default sender display name used when the from address has no
    display name; if empty the handler falls back to `system.site` `name`.
  - **`debug_mode`** (checkbox, under a *Debugging* details element) — when on, each successful
    send is logged with the parsed API response.
  - **Test email** section: `from_address` (defaults to `system.site` `mail`) and
    `recipient_address`. On submit, if both are filled, `submitForm()` sends a test message through
    `AhaSendHandler::sendMail()` and shows a warning telling you to check the logs.
- `getEditableConfigNames()` = `['ahasend.settings']`. `submitForm()` writes `api_key`,
  `from_name`, and `debug_mode`.

## Config object `ahasend.settings`

| Key | Written by | Read by | Meaning |
|-----|-----------|---------|---------|
| `api_key` | SettingsForm | `AhaSendHandler::sendMail()` | AhaSend API key, sent as `X-Api-Key` header |
| `from_name` | SettingsForm | `AhaSendHandler::sendMail()` | Default sender name fallback |
| `debug_mode` | SettingsForm | `AhaSendHandler::sendMail()` | Log each send + response when true |
| `format_filter` | (not in the form) | `AhaSendMail::format()` | Text-format id run over the body via `check_markup()`; set it via config import/drush if you want format processing |

There is **no `config/install/` default and no `config/schema/`** in this module, so config is
untyped and the object starts empty until the form is saved.

## Notes for operators

- The module has no cron, no queue, no Drush commands, and no update hooks.
- `ahasend_mail()` (in `ahasend.module`) only supplies the subject/body for the built-in test run.
- Sends are synchronous inside `AhaSendHandler::sendMail()` (a Guzzle `POST`); a non-201 API
  response or transport exception is logged to the `ahasend` logger channel and `sendMail()`
  returns `FALSE`.
