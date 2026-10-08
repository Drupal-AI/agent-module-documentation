<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail pipeline: from error to email

Two independent entry points feed the same queue + mail path.

## 1. Uncaught exceptions — `ExceptionEventSubscriber` (`src/Subscribers/ExceptionEventSubscriber.php`)

Service `exception_mailer.exception.subscriber`, tag `event_subscriber`. Subscribes to
`KernelEvents::EXCEPTION` at priority **60** (`getSubscribedEvents()`). `onException()`:

1. Returns early if config `enabled` is false or state `exception_mailer.enabled` is false.
2. Skips `FormAjaxException` and `NotFoundHttpException` (404s do not mail).
3. Builds `$data`: `exception` = `get_class($exception)`; `message` = message + `getTraceAsString()`;
   `site`; `timestamp`; `user` = `id(display name)`; `location` = request URI; `referrer` = `Referer`
   header; `hostname` = client IP; `user_roles` = current user roles.
4. Flood control via `exception_mailer__last_message_similarity('exception_mailer.log.exception', $data)`
   when `max_similar_emails` is set; returns if suppressed.
5. Resolves recipients: matching excludes (`exception` type) if any, else global config recipients.
6. Queues one `manual_exception_email` item per recipient, then **claims and processes the queue items
   inline** in the same request (`claimItem`/`processItem`/`deleteItem` loop), catching
   `SuspendQueueException` and logging other exceptions with `Error::logException`.

## 2. Log entries — `ErrorLog` (`src/Logger/ErrorLog.php`)

Service `exception_mailer.log`, tags `logger` + `backend_overridable`; PSR-3 `LoggerInterface`
(`RfcLoggerTrait`). `log($level, $message, $context)`:

1. Same enabled/state gates as above.
2. Returns unless `$level` is in configured `level_type`.
3. Fills default context if empty, drops `context['backtrace']` (unserializable), parses PSR-3
   placeholders, renders `TranslatableMarkup` messages.
4. Builds `$data` (empty `exception`, message from placeholders, `severity`, `severity_level`,
   `type` = channel truncated to 64 chars, `link`, `location` = request_uri, `referrer`,
   `hostname` = IP truncated to 128 chars, `user_roles`).
5. Flood control key `exception_mailer.log.<type>-<severity_level>`.
6. Recipient resolution (excludes `error` type else global), queue create + inline process loop.
   On a send exception it re-logs once via `RfcLogLevel::ERROR` guarded against infinite recursion by
   comparing the produced message to the item message.

## 3. QueueWorker — `ManualExceptionEmail` (`src/Plugin/QueueWorker/ManualExceptionEmail.php`)

`@QueueWorker id = "manual_exception_email"`, `cron = {"time" = 60}`. `processItem($data)` calls
`mail.manager->mail('exception_mailer', 'notify_exception', $data['email'], 'en', $params)` unless the
address equals the sentinel `placeholder-for-uid-1`. Although declared with a cron time, the two entry
points above drain the queue synchronously in-request; cron would process any leftover items.

## 4. `hook_mail()` — `exception_mailer_mail()` (`exception_mailer.module`)

Key `notify_exception`. Builds a plain-text body from the `$params` (site, formatted date, user,
location, referrer, link, type, severity, hostname, exception, message). Subject is
`An exception occurred (<class>)` or `An error occurred (<severity>)`; when the recurrence
`last_error.count > 1` the subject is prefixed `Nx ... (in last <time>)`. If `email_body` is present
(from a matching exclude) it is prepended above an `----------- Original system report -----------`
separator. Recipient langcode defaults to the site default or the recipient user's preferred langcode
(set upstream via `user_load_by_mail`).

## 5. Flood control helper — `exception_mailer__last_message_similarity()`

Keeps a per-key state record (`count`, `timespan`, `first_timestamp`, `message`) and compares the new
message with `similar_text()`. Suppresses when similarity `>= min_similarity` until `count` exceeds
`max_similar_emails` AND an escalating window (15 min → 1 h → 6 h → 24 h) has passed; resets counters
across windows. Returns whether the email should be sent and enriches `$email_data['last_error']`.

## Recipient helper — `UserRepository::getUserEmails()` (`src/Utility/UserRepository.php`)

Static; entity query for active users (`status = 1`) having any of the given role ids
(`roles IN (...)`, `accessCheck(FALSE)` — internal recipient lookup), returns their email addresses.
