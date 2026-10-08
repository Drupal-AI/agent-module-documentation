<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ACCESS Job Reporting (access_job_reporting) — agent index

Reports **TAPIS** HPC job metadata from a Drupal science gateway to the **ACCESS-CI Allocations
API** (`job_attributes` endpoint) for allocation accounting. Package `TAPIS`. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.4.1-beta1.

Depends on core **`user`** plus the TAPIS-suite modules **`tapis_job`** and **`tapis_system`**
(composer: `drupal/tapis_job:^1.4@alpha`, `drupal/tapis_system:^1.4@alpha`). Optionally uses
**`key`** to hold the API secret. No permissions.yml, no Drush, no install file.

- **Settings form, config object + schema, the Key integration, endpoint/retry options, resource
  fetcher** → [config/settings.md](config/settings.md)
- **The insert hook, per-system resource map, queue item shape, and the cron queue worker** →
  [api/reporting-pipeline.md](api/reporting-pipeline.md)

## What it provides (from source)

- **Two services** (`access_job_reporting.services.yml`):
  - `access_job_reporting.reporter` → `Drupal\access_job_reporting\AccessJobReporter` — builds the
    queue-to-resource map (`buildQueueToResourceMap()`) and enqueues report items (`enqueue()`).
  - `access_job_reporting.resource_fetcher` → `Drupal\access_job_reporting\AccessResourceFetcher` —
    POSTs to ACCESS to retrieve suggested resource names (`fetch()`), optional `@?key.repository`.
- **One QueueWorker plugin**: `AccessJobQueueWorker` (id **`access_job_reporting.job_queue`**,
  `cron time = 20`), `src/Plugin/QueueWorker/AccessJobQueueWorker.php` — drains the queue and POSTs
  each item to ACCESS.
- **One route/form**: `access_job_reporting.settings` at **`/admin/config/access/job-reporting`**,
  `_form: AccessJobReportingForm`, `_permission: administer site configuration`. Menu link under
  *Configuration → services* (`access_job_reporting.links.menu.yml`).
- **Config**: object `access_job_reporting.settings` (schema in `config/schema/`, defaults in
  `config/install/`); per-system state stored as `systems.<nid>.enabled` / `.resource_map`.
- **Hooks** (`access_job_reporting.module`): `hook_ENTITY_TYPE_insert()` for `tapis_job`
  (enqueue), `hook_form_node_form_alter()` + submit/validate handlers adding an "ACCESS Job
  Reporting" fieldset to the **`tapis_system`** node form.

## Mechanism in one paragraph

`access_job_reporting_tapis_job_insert()` → `_enqueue_for_job()`: checks
`systems.<sysid>.enabled`, loads TAPIS job metadata via `tapis_job.tapis_job_provider`, resolves
`execSystemLogicalQueue` against the per-system resource map (case-insensitive), parses the
`--account` scheduler option for the allocation, derives the user's display name / submit time /
software, and `reporter->enqueue(...)` puts an item on `access_job_reporting.job_queue`. On cron,
`AccessJobQueueWorker::processItem()` reads the API key (Key entity or config), builds
`form_params` (`gatewayuser`, `xsederesourcename`, `jobid`, `submittime`, `software`), and Guzzle-
POSTs to the endpoint with `XA-API-KEY`/`XA-AGENT` headers; failures increment `attempt_count` and
requeue up to `max_attempts`, spaced by `retry_interval`; `debug_mode` logs instead of sending.

No report-viewing route exists — data flow is one-directional (Drupal → ACCESS). No SQL, no JWT.
