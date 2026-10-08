<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How queueing works (mechanism / API)

No public service API is intended for direct calling — the module works by decorating
`symfony_mailer` and reacting to the `queue_sending` adjuster. This doc traces the real flow for
integrators.

## 1. Email factory override → QueueableEmail

`symfony_mailer_queue.services.yml` redefines the core `email_factory` service to
`Service\EmailFactory` (extends `symfony_mailer`'s `EmailFactory`). Its `newTypedEmail()` /
`newEntityEmail()` instantiate `QueueableEmail` instead of the base `Email`, and stash the raw
builder params via `setOriginalParams()` so the worker can rebuild the email later.

`QueueableEmail` (`QueueableEmailInterface`) adds:
- `markInQueue()` / `isInQueue()` — the in-queue flag.
- `getOriginalParams()` / `setOriginalParams(array)`.
- getters/setters the DTO needs: `getInner()/setInner()`, `getAddresses()/setAddresses()`,
  `getSubjectReplace()/setSubjectReplace()`.

## 2. queue_sending adjuster enqueues

When an email hits a policy carrying the `queue_sending` adjuster, `QueueSendingEmailAdjuster::build()`:
- throws `\LogicException('Attempted to queue a non-queueable email.')` if the email is not a
  `QueueableEmailInterface`;
- if `!$email->isInQueue()`: gets the queue via
  `queueFactory->get(SymfonyMailerQueueWorker::QUEUE_NAME, TRUE)`, builds a `SymfonyMailerQueueItem`
  from the email (capturing the current langcode from `language_manager`), `createItem($item)`,
  then throws `SkipMailException('The email was queued for sending')` to stop inline delivery.

Because the worker calls `markInQueue()` before sending, the same adjuster is a no-op on the
worker's send path (it does not re-queue).

## 3. SymfonyMailerQueueItem (the DTO)

`SymfonyMailerQueueItem` (`@internal`) is a readonly value object holding everything needed to
reconstruct the email off-request: `type`, `subType`, `params`, `variables`, `inner`
(`Symfony\Component\Mime\Email`), `addresses`, `sender`, `subject`, `subjectReplace`, `body`,
`theme`, `transportDsn`, `entity` (config entity or NULL), `langcode`, and `config` (the
adjuster settings). It also assigns a per-item `uniqid()` id so otherwise-identical emails are
distinguishable after serialization.

## 4. SymfonyMailerQueueWorker::processItem()

`Plugin\QueueWorker\SymfonyMailerQueueWorker` (annotation id = `QUEUE_NAME`, `cron = {"time" = 60}`):
1. Ignores items that are not `SymfonyMailerQueueItem`.
2. Restores the queued-in language: if `language` is enabled it hands the stored langcode to the
   static negotiator and resets `language_manager` (config-override language included).
3. Rebuilds the email via `email_factory->newEntityEmail(...)` (if `entity` set) or
   `newTypedEmail(...)`, then reassigns `variables`, `inner`, `addresses`, `sender`, `subject`,
   `subjectReplace`, `body`, `theme`, `transportDsn` from the item (guarded with `isset` so legacy
   items missing fields still work).
4. `markInQueue()` then `send()`. On success, `sleep(send_wait_time)` and return (item removed).
5. On failure: increments an attempt counter in `keyvalue.expirable` (`symfony_mailer_queue`
   collection, key `md5(serialize($item))`, 86400 s TTL). If attempts exceed `maximum_attempts`,
   dispatch `EmailSendFailureEvent` and return (drop). Otherwise dispatch `EmailSendRequeueEvent`
   and requeue per `queue_behavior`: `requeue` → `RequeueException`, `suspend` →
   `SuspendQueueException`, else → `DelayedRequeueException($requeue_delay)`.

## 5. StaticLanguageNegotiator

Registered as `symfony_mailer_queue.static_language_negotiator` by
`SymfonyMailerQueueServiceProvider` **only when `plugin.manager.language_negotiation_method`
exists** (i.e. `language` module on). Extends core `LanguageNegotiator`; `setLanguage()` pins a
langcode and `initializeType()` forces every language type to it, so a queued email renders in
the language of the original request rather than the cron run's default.
