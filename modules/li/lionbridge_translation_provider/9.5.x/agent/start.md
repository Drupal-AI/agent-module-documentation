<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lionbridge Translation Provider (project `lionbridge_translation_provider`) — agent index

A TMGMT translator plugin that sends translation jobs from Drupal to the **Lionbridge
Content API** (professional, human translation) and pulls the completed translations back
into the normal TMGMT review/accept workflow. Depends on `tmgmt`. Core `^9 || ^10 || ^11`.

> Documented from installed on-disk source at release **9.5.0**. The module was **not
> test-enabled this wave** (its `tmgmt` dependency could not be installed), so nothing here was
> verified against a running site — it is a source read only.

> **Project name ≠ module name.** The project is `lionbridge_translation_provider`, but the
> installable module it ships is **`tmgmt_contentapi`** (the only `.info.yml` in the package).
> Enable with `drush en tmgmt_contentapi`; `drush en lionbridge_translation_provider` fails.
> Composer still uses the project name: `composer require drupal/lionbridge_translation_provider`.
> The TMGMT translator plugin id is **`contentapi`** (`@TranslatorPlugin(id="contentapi")`).

No dedicated settings page. `configure` points at TMGMT's translator collection
(`entity.tmgmt_translator.collection`, `/admin/tmgmt/translators`) — you create a translator
of type "Lionbridge Content API Connector" there. Defines **1 permission**, **4 routes**,
**1 block**, a **plugin type** (`FormatPlugin`), several **views field/filter** plugins, and
**6 queue workers**. No drush commands.

## New in 9.5.x (vs 9.4.x)

- **Auto-Bundle** feature: an "Auto-Bundle" tab per translator
  (`/admin/tmgmt/translators/manage/{tmgmt_translator}/auto-bundle`, `AutoBundleForm`) that groups
  queued single-item submissions into larger Lionbridge jobs by content type / priority tier and
  flushes them on word-count / item-count / max-wait triggers with item/word caps. A live
  right-side status panel refreshes over AJAX
  (`.../auto-bundle/status`, `AutoBundleStatusController`). Backed by a new
  `tmgmt_contentapi_bundle_queue` install table and services
  `auto_bundle_group_key_builder` / `…_group_key_humanizer` / `…_trigger_evaluator` /
  `…_flusher` / `…_status_builder` / `auto_bundle_accumulator_subscriber` /
  `priority_field_discovery`. Evaluation runs on every `hook_cron`.
- **Continuous jobs**: `ContinuousJobService`, a "Submissions" tab on each job
  (`/admin/tmgmt/jobs/{tmgmt_job}/submissions`, `ContinuousSubmissionsController`), a
  `ContinuousReQueueSubscriber`/`ContinuousReQueueSuppressor`, a duplicate-continuous-job
  validator, and a **workflow-state gate** (`WorkflowGateSubscriber`) that blocks job creation
  until content reaches required moderation states (`continuous_settings.workflow_states_required`).
- **Config schema** now shipped for the first time
  (`config/schema/tmgmt_contentapi.translator.schema.yml`), covering the new `auto_bundle` and
  `continuous_settings` setting groups — hence `provides_config_schema: true`.
- Routes grew from 1 → 4; a third install table (`tmgmt_contentapi_bundle_queue`) was added.

Solution docs:
- **Configure the Lionbridge translator (credentials, host, provider, cron auto-import)** → [configure/translator.md](configure/translator.md)
- **Auto-Bundle + continuous jobs + workflow gate (routes, services, settings)** → [configure/auto-bundle.md](configure/auto-bundle.md)
- **Public services + the submit / poll / import runtime flow + the queue-process route** → [api/services.md](api/services.md)
- **Permissions (`access queue process`) + route access control** → [permissions/permissions.md](permissions/permissions.md)
- **The `FormatPlugin` export-format plugin type (add your own)** → [plugins/format.md](plugins/format.md)
- **Hooks it implements (cron, form/entity-op alters, tmgmt_job_delete, views)** → [hooks/hooks.md](hooks/hooks.md)
- **The Queue Status block** → [blocks/queue-status.md](blocks/queue-status.md)
- **Views fields/filters over the connector tables** → [views/views.md](views/views.md)

Key facts:
- Module machine name: `tmgmt_contentapi`. Translator plugin id: `contentapi`.
- Translator config entity: `tmgmt.translator.contentapi` (settings live under `settings.*`).
- Credential/host keys: `settings.capi-settings.capi_username_ctt` (Client ID),
  `capi_password_ctt` (Client Secret), `capi_host` (default `https://contentapi.lionbridge.com/v2`),
  `provider`. Token endpoint: `https://login.lionbridge.com/connect/token`.
- Cron: `tmgmt_contentapi_cron()` — polls Lionbridge status updates, (if enabled) auto-imports,
  and evaluates/flushes mature auto-bundles.
- Permission: `access queue process` (restrict access TRUE).
- Routes: `tmgmt_contentapi.queue_process_in_bg` (POST, `access queue process` + CSRF),
  `tmgmt_contentapi.continuous_submissions`, `tmgmt_contentapi.translator_auto_bundle`,
  `tmgmt_contentapi.auto_bundle_status_refresh` (latter three: entity `update`-access custom checks).
- Block: `queue_status_block`. Plugin type: `FormatPlugin` (manager `plugin.manager.tmgmt_contentapi.format`).
- Install tables: `tmgmt_capi_request_processor`, `tmgmt_capi_response`, `tmgmt_contentapi_bundle_queue`.
- Optional "Analysis Code" feature talks to the Lionbridge Freeway SOAP API
  (`settings.code-analysis-settings.*`).
