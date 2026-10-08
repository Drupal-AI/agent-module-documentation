<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Service UI (cron_service_ui) — agent index

Optional admin submodule of **Cron Service Manager**. Adds an overview page listing every registered
`cron_service`-tagged job with its schedule and a **"Force on next Cron run"** action. Depends on
`cron_service`. Version 2.0.5 (dir `2.0.x`), core `^10 || ^11`, GPL-2.0-or-later. No config, entities
or schema of its own.

- **Routes, permission, list builder, force form — how the UI works** → [ui/overview.md](ui/overview.md)

## What it provides (from source)

- **Routes** (`cron_service_ui.routing.yml`), both requiring permission `access cron service ui`:
  - `cron_service_ui.services.overview` — `GET /admin/config/system/cron/services` →
    `ServiceListController::overview()`.
  - `cron_service_ui.service.force` — `/admin/config/system/cron/services/{id}/force` → form
    `ForceServiceForm`.
- **Permission** (`cron_service_ui.permissions.yml`): `access cron service ui` (`restrict access: true`).
- **Service** `cron_service_ui.list_builder` = `ServiceListBuilder` (arg `@service_container`).
- **Menu/tasks**: overview linked under core `system.cron_settings`; local tasks "Settings" +
  "Services" (`*.links.menu.yml`, `*.links.task.yml`).
- **Classes** (`src/`): `Controller\ServiceListController`, `ServiceListBuilder(Interface)`,
  `Form\ForceServiceForm` (a `ConfirmFormBase`).

## Mechanism

- The overview renders `ServiceListBuilder::build()`: a table over
  `cron_service.manager->getHandlerIds()` — id (plain text), schedule text (from
  `getScheduledCronRunTime()` / `isForced()`), and a "Force on next Cron run" operation link.
- Forcing opens `ForceServiceForm` (confirm form) → on submit calls
  `cron_service.manager->forceNextExecution($id)`; the job runs (bypassing its schedule) on the next
  cron run, not immediately.
