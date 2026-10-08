<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Insta Queue extends Drupal's queue system so that queue items can be processed instantly (in near-realtime) rather than waiting for cron, by decorating the queue worker manager and notifying an external scheduler daemon whenever items are created.

---

The module decorates `plugin.manager.queue_worker` with an `InstaQueueWorkerManager`, provides an `InstaDatabaseQueue`/factory, an `InstaQueueProcessor`, and dispatches events (item created/claimed/released/delayed/deleted) via `InstaQueueEventSubscriber`. A `SchedulerClient` notifies a scheduler process over a TCP or Unix socket using `SchedulerConnection` (`stream_socket_client`); the connection address comes from `settings.php` (`insta_queue.scheduler_connection`). Drush commands are provided for worker and scheduler operations, and `insta_queue.process_max_time` bounds processing time.

This is developer/queue infrastructure. Security note: the scheduler socket address is read from trusted `settings.php`, not from request input, so there is no request-driven SSRF; the payloads are fixed control strings (`item_created:…`, `reload`, `ping`). The module exposes no HTTP routes or permissions.

---

- Process queue items in near-realtime instead of on cron.
- Notify an external scheduler when items are enqueued.
- Connect to the scheduler over TCP or a Unix socket.
- Decorate the core queue worker manager.
- Provide an instant database queue backend.
- Dispatch events on queue item lifecycle changes.
- Subscribe to queue events to trigger scheduling.
- Configure the scheduler connection in `settings.php`.
- Run worker operations via Drush commands.
- Run scheduler operations via Drush commands.
- Bound processing time with a max-time parameter.
- Support realtime background job pipelines.
- Reuse existing queue worker plugins.
- Send fixed control messages to the scheduler.
- Avoid cron latency for time-sensitive queues.
- Expose no HTTP routes or permissions.
