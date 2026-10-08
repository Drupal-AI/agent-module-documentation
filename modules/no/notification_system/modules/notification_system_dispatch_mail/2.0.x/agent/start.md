<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notification System Dispatch Mail (notification_system_dispatch_mail) — agent index

The **email channel** for `notification_system_dispatch`. Registers a single `mail`
`notification_system_dispatcher` plugin. Depends on `notification_system` +
`notification_system_dispatch`. `configure: notification_system_dispatch_mail.settings`.

## Solution doc
- **The `mail` dispatcher, hook_mail, templates, config** → [plugins/mail-dispatcher.md](plugins/mail-dispatcher.md)

## Provides
- Plugin **`mail`** (`src/Plugin/NotificationSystemDispatcher/MailDispatcher.php`,
  `@NotificationSystemDispatcher(id="mail")`). `dispatch(UserInterface $user, array $notifications)`
  → `MailManager::mail('notification_system_dispatch_mail', 'new_notification', $user->getEmail(), $langcode, ['notifications'=>…])`.
  Returns early if the user has no email. `settingsForm()` adds `subject_template` + `body_template`
  textareas (embedded in the dispatch settings form); `settingsFormSubmit()` writes them.
- `hook_mail` (`notification_system_dispatch_mail_mail`) key `new_notification`: sets `from` to the
  site mail, builds a `notifications` Twig variable (each: `title`, `body`, `timestamp`, `link`,
  `direct_link`), renders `subject_template` (wrapped in `{% apply spaceless %}`) and
  `body_template` via `twig->renderInline`. If `swiftmailer` is enabled, sets HTML content type.

## Config
`notification_system_dispatch_mail.settings` — `subject_template`, `body_template` (both `text`).
Install defaults + schema in `config/`. Config-translatable
(`notification_system_dispatch_mail.config_translation.yml`, base route
`notification_system_dispatch.settings`). Update hook 8001 seeds the templates.

## No routes, no permissions, no plugin types of its own.
