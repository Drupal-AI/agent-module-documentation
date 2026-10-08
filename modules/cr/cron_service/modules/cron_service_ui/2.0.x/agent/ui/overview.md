<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Service UI — routes, permission, list builder, force form

Install: `drush en cron_service_ui`. Requires the parent `cron_service` module. No config to set up.

## Permission (`cron_service_ui.permissions.yml`)

- `access cron service ui` — title "Access Cron Service UI", `restrict access: true` (security-
  sensitive admin permission). Gates **both** routes below. Grant only to trusted admin roles.

## Routes (`cron_service_ui.routing.yml`)

- `cron_service_ui.services.overview` — `GET /admin/config/system/cron/services`,
  `_controller: ServiceListController::overview`, `_permission: 'access cron service ui'`. Read-only
  listing.
- `cron_service_ui.service.force` — `/admin/config/system/cron/services/{id}/force`,
  `_form: ForceServiceForm`, `_permission: 'access cron service ui'`. State-changing, but rendered as
  a confirm form (POST + confirm), so it is CSRF-protected by the form system.

Menu: overview appears under core `system.cron_settings` (Configuration → System → Cron) as the
"Services" local task; "Settings" tab points back to core cron settings (`*.links.task.yml`,
`*.links.menu.yml`).

## `ServiceListController` (`src/Controller/ServiceListController.php`)

Thin controller. `create()` pulls `cron_service_ui.list_builder`; `overview()` returns
`['services' => $this->serviceListBuilder->build()]`.

## `ServiceListBuilder` (`src/ServiceListBuilder.php`, service `cron_service_ui.list_builder`)

Constructed with `@service_container`; pulls `cron_service.manager` and `date.formatter` from it.

- `build()` — a `#type => table` with header Service name / Schedule / Operations, one row per
  `cronServiceManager->getHandlerIds()`.
- `buildServiceName($id)` — `#plain_text => $id` (machine name, escaped).
- `buildServiceNextRun($id)` — reads `getScheduledCronRunTime($id)` and `isForced($id)`:
  - forced → "Forced for the next Cron run" (+ "Was scheduled for <time>" if a schedule existed);
  - else scheduled → "Scheduled for <formatted time>"; else "Will be executed at next Cron run";
  - if the service instance (fetched via `container->get($id)`) is a
    `TimeControllingCronServiceInterface`, adds a note that it may still self-veto until forced.
- `buildServiceOperations($id)` — `#type => operations` with one link "Force on next Cron run" →
  route `cron_service_ui.service.force` (`id` = service id).

## `ForceServiceForm` (`src/Form/ForceServiceForm.php`, extends `ConfirmFormBase`)

- `create()` pulls `cron_service.manager`. `getFormId()` = `cron_service_ui_force_service`.
- `buildForm($form, $form_state, ?string $id = NULL)` — throws `InvalidArgumentException` if `$id` is
  missing; stores it in form state; overrides the description to name the `%id` service. (A `@todo`
  notes it does not verify the id is a real service.)
- `getQuestion()` — "Are you sure to execute the service on the next Cron run?";
  `getCancelUrl()` → overview route.
- `submitForm()` — calls `cronServiceManager->forceNextExecution($id)`, adds a status message
  ("Service execution forced."), redirects to the overview. **Does not run the job immediately** — it
  sets the `forced` State flag so the job bypasses its schedule on the next cron run.

## Operating it

Go to Configuration → System → Cron → **Services**, find a job, use **Force on next Cron run**,
confirm. The job runs on the next cron tick regardless of its schedule/gate. There is no "run right
now" button in the UI; immediate execution is only available programmatically via
`CronServiceManager::executeHandler($id, TRUE)`.
