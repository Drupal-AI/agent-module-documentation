<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Insta Queue — agent index

**Instant/realtime** queue processing: decorates the queue worker manager and notifies an external **scheduler daemon** on enqueue. Version **1.0.0**. Core `^10`.

- Services in `insta_queue.services.yml` (autowired): `InstaQueueWorkerManager`, `InstaDatabaseQueue`, `InstaQueueProcessor`, `SchedulerClient`.
- `SchedulerConnection` uses `stream_socket_client` to an address from `settings.php` (`insta_queue.scheduler_connection`) — not request-driven (no SSRF). Fixed control payloads. No HTTP routes/permissions.
