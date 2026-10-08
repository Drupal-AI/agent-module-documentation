<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings form

## Install & enable

```bash
composer require drupal/phpmail_alter
drush en phpmail_alter -y
```

No declared module dependencies, no sub-modules, no permissions of its own, no Drush commands.
Contact-form attachment support (see [../api/service.md](../api/service.md)) implicitly needs the
core `file` + `contact` stack, but the module's `.info.yml` does **not** declare them.

## Config object: `phpmail_alter.settings`

There is **no config schema** (`config/schema/` is absent); only install defaults exist in
`config/install/phpmail_alter.settings.yml`:

```yaml
phpmail: 1
from: do-not-reply@s1dev.ru
debug: 0
langcode: ru
reply: do-not-reply@s1dev.ru
```

| Key | Type | Default | Effect |
|---|---|---|---|
| `phpmail` | bool (0/1) | `1` | When on, the alter hook routes delivery through the `phpmail_alter` backend and prevents core from also sending. |
| `from` | string | `do-not-reply@s1dev.ru` | Written to `$message['headers']['From']` for every outbound message. Accepts `Name <addr@example.com>` form; the name part is MIME-encoded at send. |
| `reply` | string | `do-not-reply@s1dev.ru` | Written to the `Reply-to` header when the message has no `reply-to` set; also becomes the `List-Unsubscribe` mailto. |
| `debug` | bool (0/1) | `0` | When on, `DebugService::debug()` logs a full dump of each send to the `phpmail_alter` logger channel. |

> The shipped defaults point at `s1dev.ru`. **Change `from`/`reply` to your own domain** on
> install — otherwise all outbound mail advertises the maintainer's placeholder address, which
> hurts deliverability and misrepresents the sender.

## Settings form

`src/Form/Settings.php` (`Settings extends ConfigFormBase`, form id `phpmail_alter_settings`),
route **`phpmail_alter.settings`** at `/admin/config/system/phpmail-alter`, requirement
`_permission: 'administer site configuration'`. Menu link `phpmail_alter.settings` sits under
`system.admin_config_system` (*Configuration → System*, title "PhpMail Settings").

`getEditableConfigNames()` returns `['phpmail_alter.settings']`. `buildForm()` calls
`module_set_weight('phpmail_alter', 15)` so the module's `hook_mail_alter()` runs late, and
renders one `details` group ("General settings") with four fields:

- **Rewrite drupal PhpMail** (`phpmail`, checkbox) — "Better works with non-latin From & allow send text/html".
- **From Header** (`from`, textfield).
- **Reply to** (`reply`, textfield).
- **Debug mode** (`debug`, checkbox) — "Log full sendmail information".

`submitForm()` saves those four values back to `phpmail_alter.settings`. No custom validation.

### Config-set equivalent

```bash
drush cset phpmail_alter.settings from 'MySite <webmaster@example.com>' -y
drush cset phpmail_alter.settings reply 'support@example.com' -y
drush cset phpmail_alter.settings phpmail 1 -y
drush cset phpmail_alter.settings debug 0 -y
drush cr
```

Leave `debug` off in production — it writes recipient, subject, body and headers to the log.
