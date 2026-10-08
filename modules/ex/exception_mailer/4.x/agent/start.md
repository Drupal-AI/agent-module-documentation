<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Error & Exception Mailer (exception_mailer) — agent index

Sends plain-text email alerts when an uncaught exception is thrown OR a log message at a selected
RFC severity level is recorded. Core module, no external services, no composer requirements.

- **Machine name:** `exception_mailer` · **Version dir:** `4.x` (installed 4.0.10) · **License:** GPL-2.0-or-later
- **Core:** `^10 || ^11` · **Package:** Custom
- **Declared dependencies:** none in `.info.yml` (uses core `user` role/entity APIs at runtime).
- **Config route:** `exception_mailer.exception_mailer_config_form` → `/admin/config/exception-mailer/config`.

## What it provides

- **Event subscriber** `exception_mailer.exception.subscriber` (`src/Subscribers/ExceptionEventSubscriber.php`)
  — subscribes to `KernelEvents::EXCEPTION` (priority 60); mails on uncaught throwables (skips
  `FormAjaxException` and 404 `NotFoundHttpException`).
- **Logger backend** `exception_mailer.log` (`src/Logger/ErrorLog.php`) — tagged `logger` +
  `backend_overridable`; PSR-3 logger that mails on log entries whose severity is a selected level.
- **QueueWorker plugin** `manual_exception_email` (`src/Plugin/QueueWorker/ManualExceptionEmail.php`)
  — actually sends each queued item via the mail manager (`exception_mailer` / `notify_exception` key).
- **Config entity type** `exception_mailer_exclude` (`src/Entity/ExceptionMailerExclude.php`,
  config_prefix `exception`) — per-case include/exclude + recipient/body/interval override rules.
- **Manager service** `exception_mailer.exception.manager` (`src/ExceptionMailerExcludeManager.php`)
  — loads and filters active excludes against the current error/exception data.
- **hook_mail()** `notify_exception` and **helper** `exception_mailer__last_message_similarity()`
  (flood control) in `exception_mailer.module`.
- **Config object** `exception_mailer.settings` + schema (`config/schema/exception_mailer.schema.yml`).

## Routes & permissions

All routes in `exception_mailer.routing.yml` require the core permission `administer site configuration`:
settings form, exclude collection/add/edit/delete. The module ships **no** `*.permissions.yml`.

## Solution docs

- [config/settings.md](config/settings.md) — install/enable, the `exception_mailer.settings` config
  object, the settings form, level selection, recipients, flood control, and the enable/disable state key.
- [config/excludes.md](config/excludes.md) — the `exception_mailer_exclude` config entity: fields,
  schema, matching logic, per-exclude recipients/body/interval, and admin routes.
- [api/mail-pipeline.md](api/mail-pipeline.md) — how an exception/error becomes an email: the
  subscriber, the logger backend, the queue worker, `hook_mail`, and the similarity flood control.
