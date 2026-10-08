<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bureau Works TMGMT Connector (bureauworks_tmgmt) — agent index

A **TMGMT translator plugin** connecting Drupal to the **Bureau Works** localization platform. Project
`bureau_works_tmgmt_connector`; module machine name **`bureauworks_tmgmt`**; info `name: 'Bureau Works'`,
package *Translation Management*. Core `^10 || ^11`. Version 1.0.3. License GPL-2.0-or-later.
Depends on **`tmgmt`** and **`tmgmt_file`** (XLIFF export/import). No composer.json, no libraries.

- **Provider config, all translator settings, job/checkout options, operating flow** →
  [config/settings.md](config/settings.md)
- **The `bwx` translator plugin, the Bureau Works API client, submit + delivery/import flow** →
  [plugins/translator.md](plugins/translator.md)
- **Cron polling, the two queue workers, continuous jobs, cache gatekeeping, Views fields** →
  [plugins/cron-queues.md](plugins/cron-queues.md)

## What it actually is (from source)

- One **TMGMT translator plugin**: `BureauTranslator` (id **`bwx`**, label *"Bureau Works"*), in
  `src/Plugin/tmgmt/Translator/BureauTranslator.php`, extending `TranslatorPluginBase` and implementing
  `ContinuousTranslatorInterface`. UI class `BureauTranslatorUi` (`src/BureauTranslatorUi.php`).
- **No routing.yml, no permissions.yml, no services.yml, no *.links.*.yml, no Drush.** All operation is
  through TMGMT's own screens (Translation → Providers / Sources / Jobs), gated by TMGMT permissions
  (`administer tmgmt`, job access). Config is a TMGMT `tmgmt_translator` config entity.
- **Config schema**: `config/schema/bureauworks_tmgmt.schema.yml` declares
  `tmgmt.translator.settings.bureau` with `end_point_api`, `accesskey`, `secretAccesskey` (note the schema
  key uses `.bureau`, not the plugin id `bwx`, and omits the many other settings the code reads —
  see config/settings.md).
- **Two QueueWorker plugins** (`src/Plugin/QueueWorker/`): `bureauworks_tmgmt.job_queue`
  (`BureauApiJobQueueWorker` — continuous re-submission of changed nodes) and `bureauworks_tmgmt.fetch_queue`
  (`BureauApiFetchQueueWorker` — import delivered translations). Both `cron = {"time" = 30}`.
- **Two Views field handlers** (`src/Plugin/views/field/`) attached to `tmgmt_job_item` via
  `hook_views_data_alter`: `bw_project_name` (`BureauWorksProjectNameField`) and
  `bw_last_workflow_delivered` (`BureauWorksLastWorkflowDeliveredField`). Both `Html::escape()` output.
- **Helpers** (`src/Helper/`): `BureauCacheHelper` (thin wrapper over `\Drupal::cache()`) and
  `QueueGateKeeper` (queue dedup / requeue / entity-update cache gating for continuous jobs).
- **`.module` hooks**: `hook_entity_update` (queues changed tracked nodes for continuous jobs),
  `hook_cron` (polls Bureau Works for deliveries), `hook_views_data_alter`, `hook_uninstall`
  (removes the two custom Views fields from the `tmgmt_translation_all_job_items` view).

## Mechanism in one breath

Editor submits a TMGMT job → `BureauTranslator::requestJobItemsTranslation()` authenticates to Bureau Works
`/api/v3` (POST `/auth`, caches `X-AUTH-TOKEN` ~120s), creates a project, uploads each job item's XLIFF as a
resource + work units, stores project/resource UUIDs on the job item's TMGMT **remote mapping**. Delivery is
**pull-based**: `bureauworks_tmgmt_cron()` enqueues active/review items → `fetch_queue` worker →
`importAndCleanup()` asks the API for the latest delivered work unit, downloads + extracts the translated
XLIFF, validates it belongs to the same TMGMT job, and imports via `Xliff::import()`. Continuous jobs:
`hook_entity_update` → `job_queue` worker re-submits changed tracked nodes.

## Key settings (translator provider)

`end_point_api`, `accesskey`, `secretAccesskey`, `orgUnitUUID`, `contactUUID`, `workflows` (CSV),
`autoSaveTranslationsForWorkflows` (CSV), `autoAcceptableWorkflows` (CSV), `shouldSendPreviewUrl`,
`previewBaseUrl`. Job-level checkout: `name`, `comment`, `duedate`. See
[config/settings.md](config/settings.md).
