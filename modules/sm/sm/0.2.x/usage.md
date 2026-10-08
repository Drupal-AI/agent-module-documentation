<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Messenger integration (sm) brings the Symfony Messenger message bus to Drupal, letting developers dispatch messages that are handled synchronously or asynchronously through configurable transports (queues).

---

Install with Composer (`composer require drupal/sm`), which pulls the required `symfony/messenger`, `symfony/lock`, `symfony/property-access` and `symfony/runtime` libraries, then enable the module (`drush en sm`); it needs Drupal `^10.5 || ^11.2` and PHP 8.2+. Configuration is done in code with **container parameters** placed in a site `services.yml` referenced from `settings.php` — `sm.buses` (message buses), `sm.transports` (e.g. `synchronous` → `sync://`, `asynchronous` → the bundled `drupal-sql://default` transport that stores messages in a database table, and `failed`), `sm.routing` (which message class goes to which transport), `sm.default_bus` and `sm.failure_transport`. Enable the optional **`sm_config`** submodule to manage routing through an admin form at `/admin/config/messenger/routing` (permission `administer sm_config configuration`) and persist it in Drupal config. Developers create a message class plus a handler class in a module's `src/Messenger/` directory annotated with `#[AsMessageHandler]` (discovered on `drush cr`), then dispatch via `\Drupal::service('messenger.default_bus')->dispatch($message)`. Asynchronous messages are processed by the standalone console worker `vendor/bin/sm messenger:consume asynchronous` (run under Supervisor or cron with `--time-limit`), with `messenger:stats` and `messenger:failed:show|retry|remove` for monitoring and recovery. SM can also intercept the legacy Drupal Queue API (set `$settings['queue_default']` to `SmLegacyQueueFactory::class`) so existing `@QueueWorker` plugins route through the bus. Note: uninstalling the module removes its configuration and drops its message tables.

---

- Add asynchronous/background processing to a Drupal site with Symfony Messenger.
- Dispatch a message onto the default bus from any code.
- Define custom message classes and `#[AsMessageHandler]` handlers.
- Route specific message classes to specific transports.
- Process messages synchronously (immediately) by leaving them unrouted.
- Queue messages to the bundled Drupal SQL transport for later processing.
- Run multiple named/prioritised transports (e.g. high vs low priority).
- Consume queued messages with `sm messenger:consume`.
- Keep a long-running worker alive with Supervisor or a `--time-limit` cron job.
- Monitor pending message counts with `sm messenger:stats`.
- Inspect failed messages with `sm messenger:failed:show`.
- Retry a failed message after fixing a transient error (`messenger:failed:retry`).
- Remove a failed message without handling it (`messenger:failed:remove`).
- Automatically retry failing handlers with exponential backoff before failing.
- Throw `RecoverableMessageHandlingException` to force a retry.
- Deduplicate messages with a `DeduplicateStamp` unique id.
- Rate-limit a transport with a Symfony rate limiter.
- Configure message routing in the UI via the `sm_config` submodule.
- Persist routing configuration in Drupal config with `sm_config`.
- Replace the core Queue API so `@QueueWorker` items run through the bus.
- Use it as a more capable alternative to Drupal's queue system.
- Send emails or notifications asynchronously (with companion transport/mailer modules).
- Configure buses and middleware per site.
- Point transports at external brokers (Redis, AMQP) via add-on transport modules.
