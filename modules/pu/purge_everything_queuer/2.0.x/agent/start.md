<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge Everything Queuer — agent orientation

Purge `everything` queuer + `queueEverything()` service; cron auto-flushes when the queue exceeds 100k items.

- Version 2.0.x, core `^9.3||^10`, dep purge. No routes/forms/permissions/config.
- `QueueEverything::queueEverything()` empties queue + adds one everything invalidation (no-ops if unsupported). `hook_cron` triggers at >=100,000 queued items, then reloads diagnostics + cron processor.
- Operational utility only; no untrusted input, no external calls. Nothing exploitable.