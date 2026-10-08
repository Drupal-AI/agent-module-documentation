<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `mail` dispatcher

## Plugin (`src/Plugin/NotificationSystemDispatcher/MailDispatcher.php`)
`@NotificationSystemDispatcher(id="mail", label="Mail", description="Send notifications via mail.")`.
Injects `plugin.manager.mail` + `logger.factory`; holds an editable
`notification_system_dispatch_mail.settings`.

- `dispatch(UserInterface $user, array $notifications)`:
  - `$to = $user->getEmail()`; **returns early if empty** (no recipient).
  - `MailManager::mail('notification_system_dispatch_mail', 'new_notification', $to,
    $user->getPreferredLangcode(), ['notifications' => $notifications], NULL, TRUE)`.
  - logs a warning if the mail result is not TRUE.
- `settingsForm()` — help text listing the available Twig variables, plus `subject_template` and
  `body_template` textareas (required). These render inside the parent dispatch settings form under
  the `configure_dispatcher_mail` fieldset.
- `settingsFormSubmit(array $values)` — saves `subject_template` + `body_template`.

## `hook_mail` (`notification_system_dispatch_mail_mail`, key `new_notification`)
- `from` = `system.site:mail`.
- Builds `variables['notifications']`: for each notification, `title`, `body`, `timestamp`
  (medium date), `link` (a literal `http://example.com` placeholder), `direct_link` (absolute URL
  of the notification's link).
- `subject` = `twig->renderInline('{% apply spaceless %}' . subject_template . '{% endapply %}', vars)`.
- `body[]` = `twig->renderInline(body_template, vars)`.
- If `swiftmailer` module exists, sets `headers['Content-Type'] = SWIFTMAILER_FORMAT_HTML`.

The recipient address is always the target user's own account email (`$user->getEmail()`), never a
value taken from the notification content.

## Config
- Object `notification_system_dispatch_mail.settings`: `subject_template`, `body_template` (`text`).
- `config/install/…settings.yml` ships default templates (single-vs-multiple subject, a `<p>`/`<hr>`
  body loop). Schema `config/schema/…settings.schema.yml`. Update hook 8001 migrates old
  `subject`/`body`/`body_format` keys to the template keys.
- Config-translatable via `notification_system_dispatch_mail.config_translation.yml`.

## Operate
Enable, then configure the templates at the dispatch settings form
(`/admin/config/system/notification-system-dispatch`, fieldset "Configure Mail dispatcher"). Users
must have the `mail` channel enabled (default channels are set in the same form) and an email
address. Delivery runs through the dispatch queue on cron.
