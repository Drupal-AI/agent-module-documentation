<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue Processor (queue_processor) — agent index

**Drains configured queue workers on `kernel.terminate` (after the response), with per-queue priority, time limits, and an alter hook — a traffic-driven cron alternative.**

- **Version:** 1.0.x  •  core: `^10 || ^11`  •  PHP 8.3+  •  installed release 1.0.0-alpha1.
- **Engine:** `QueueProcessorSubscriber` on `KernelEvents::TERMINATE` (priority -100). Reads `queue_processor.settings`; honours `enabled`, `run_on_admin_routes`, per-queue `priority`/`time_limit`, global `max_execution_time`, `logging`. Fires `hook_queue_processor_queues_alter()`.
- **Config route:** `queue_processor.settings` → `/admin/config/system/queue-processor` (`QueueProcessorSettingsForm`), **gated by `administer site configuration`**.
- **Config:** `queue_processor.settings` (defaults: enabled=true, max_execution_time=5, run_on_admin_routes=false, logging=errors_warnings).
- **Security (asked to verify):** there is **no route/endpoint that triggers queue processing on demand** — processing happens only implicitly on kernel terminate of normal requests; the only route is the admin-gated settings form. Note workers therefore run in the context of ordinary (incl. anonymous) front-end requests. No exposed trigger; **no security findings.**

See [configure/settings.md](configure/settings.md) for settings and the alter hook.
