<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Consolidated logging for the API Sync suite: subscribes to API Sync log events and records them to a dedicated logger channel with a configurable minimum level.

---

`apisync_logger` provides an event subscriber (`ApiSyncLoggerSubscriber`) that listens to the suite's `ApiSyncEvents::ERROR`, `WARNING`, and `NOTICE` events (dispatched throughout `apisync_pull`, `apisync_push`, and mapping/push operations) and writes them to the `apisync` logger channel (visible in dblog / syslog). A settings form (`/admin/config/apisync/logger`) sets the minimum log level — errors only (default), warnings and errors, or all events — so noisy notice-level sync messages can be suppressed in production. `apisync_mapping` depends on this module, so it is present whenever mapping is used.

---

- Record API Sync error / warning / notice events to watchdog.
- Route all suite log events through a single `apisync` logger channel.
- Configure the minimum log level (error / warning / notice).
- Suppress low-severity sync notices in production.
- Capture exception details (message, function, line, file) for failed pushes/pulls.
- Provide the logging backbone that `apisync_mapping` depends on.
- Diagnose sync failures from standard Drupal logs.
- Integrate suite events with syslog / external log aggregation via core logging.
