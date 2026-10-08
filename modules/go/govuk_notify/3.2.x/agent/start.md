<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GOV Notify Integration (govuk_notify) — agent index

Sends Drupal **email and SMS** through a Government **Notify** service — Gov.UK Notify (default),
Government of Canada Notification (`ca`), or Australian Government Notify (`au`). It registers a
core **Mail plugin** `govuk_notify_mail` and a service wrapping the official
`alphagov/notifications-php-client`. Core `^10.3 || ^11`, version 3.2.x, GPL-2.0-or-later.

- **Install, the settings form, config object + keys, service switching, testing** →
  [config/settings.md](config/settings.md)
- **The mail plugin: how email vs SMS is chosen, template/placeholder handling, sending API** →
  [api/mail-and-send.md](api/mail-and-send.md)
- **`govuk_notify_views_backend` submodule (message-log Views base table)** →
  `modules/govuk_notify_views_backend/3.2.x/` (own data.json + agent docs)

## Dependencies

- Composer (NOT Drupal modules): `alphagov/notifications-php-client:^7.0.0` and
  `php-http/guzzle7-adapter:*`. No `dependencies:` in the info.yml — no Drupal module deps.
- Uses core services only: `config.factory`, `cache.data`, `logger.channel_base`,
  `plugin.manager.mail`, `email.validator`, `current_user`.

## What it provides (from source)

- **Service** `govuk_notify.notify_service` → `Drupal\govuk_notify\NotifyService\GovUKNotifyService`
  (interface `NotifyServiceInterface`): `sendEmail`, `sendSms`, `getTemplate` (cached),
  `checkReplacement`, `listNotifications`. Constructs the `Alphagov\Notifications\Client` in its
  constructor from `govuk_notify.settings` (base URL chosen by service, `apiKey`, Guzzle7 adapter).
- **Mail plugin** `govuk_notify_mail` → `src/Plugin/Mail/GovUKNotifyMail.php` (annotation `@Mail`).
  `hook_install()` registers it into `system.mail` `interface`; `hook_uninstall()` removes it.
- **Logger channel** service `govuk_notify.logger_channel` (channel `govuk_notify`).
- **Route** `govuk_notify.admin_settings_form` → `/admin/config/system/govuk_notify`
  (`GovUKNotifyAdminForm`, `ConfigFormBase`), permission **`administrator gov uk notify`**,
  menu link under *Configuration → System*.
- **Permission** `administrator gov uk notify` (`govuk_notify.permissions.yml`).
- **Config object** `govuk_notify.settings` (no `config/install`, no `config/schema` shipped).
- **Submodule** `govuk_notify_views_backend` — a Views query/filter backend over the Notify
  message log (documented in its own tree).

No entities, no Drush commands, no config schema, no new plugin types.
