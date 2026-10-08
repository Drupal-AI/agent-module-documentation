<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bureau Works TMGMT Connector registers Bureau Works as a translation provider for the Translation Management Tool (TMGMT), so editors can send Drupal content to the Bureau Works localization platform and pull the finished translations back into Drupal.

---

The module (machine name `bureauworks_tmgmt`, project `bureau_works_tmgmt_connector`) provides one TMGMT translator plugin, `BureauTranslator` (plugin id `bwx`), plus its configuration UI `BureauTranslatorUi`. You add a Bureau Works provider under **Translation → Providers**, enter the API endpoint, Access Key and Secret Key, and set project options (Org Unit UUID, Contact UUID, comma-separated Workflows, auto-save/auto-accept workflow lists, and optional preview URLs). When an editor requests translation, `requestJobItemsTranslation()` authenticates against the Bureau Works `/api/v3` REST API (POST `/auth`, caching the returned `X-AUTH-TOKEN` for ~2 minutes), creates a project (`project/ci`), exports each TMGMT job item as XLIFF via `tmgmt_file`, creates a resource, uploads the file, and assigns work units for the configured workflows; the Bureau Works project UUID, resource UUID and project name are stored on each job item's TMGMT remote mapping. Delivery is **pull-based**: `hook_cron` (`bureauworks_tmgmt_cron`) scans active/review job items and enqueues them on the `bureauworks_tmgmt.fetch_queue` queue worker, which calls `importAndCleanup()` — that method asks the API for the latest delivered work unit, and if a newer delivery exists, downloads the translated XLIFF (async download request + polling), extracts it, validates it against the originating TMGMT job, and imports it with `Xliff::import()`. Depending on the `autoAcceptableWorkflows` / `autoSaveTranslationsForWorkflows` settings, imported content is auto-accepted or auto-saved. The module also supports TMGMT **continuous jobs**: `hook_entity_update` detects changes to already-tracked translatable nodes and queues them (`bureauworks_tmgmt.job_queue`) for automatic re-submission, with cache-based gatekeeping (`QueueGateKeeper`, `BureauCacheHelper`) to avoid duplicate and loop submissions. Two Views field handlers, `BureauWorksProjectNameField` (`bw_project_name`) and `BureauWorksLastWorkflowDeliveredField` (`bw_last_workflow_delivered`), are attached to `tmgmt_job_item` so job listings can show the Bureau Works project name and last delivered workflow. The module ships no custom routes, no permissions of its own, and no Drush commands; all operation is through the standard TMGMT screens (gated by TMGMT's `administer tmgmt` / job permissions).

---

- Add Bureau Works as a translation provider for a multilingual Drupal site that already uses TMGMT.
- Submit selected nodes/content (TMGMT sources) to professional human + AI translation at Bureau Works from the Sources page.
- Send a whole batch of job items as a single Bureau Works project with one due date and comment.
- Track the Bureau Works project ID and status from the TMGMT Jobs screen.
- Pull delivered translations back into Drupal automatically on cron, without manual polling.
- Manually pull translations on demand with the "Fetch translations" button on an active job.
- Auto-accept translations once a configured workflow stage (e.g. `REVIEW_2`) is delivered.
- Auto-save (but not accept) translations for a given workflow stage so a reviewer can approve them in Drupal.
- Run continuous translation: automatically re-submit a node to Bureau Works whenever its translatable fields change.
- Restrict continuous re-submission to nodes that have already been part of a translation job (tracked entities only).
- Map Drupal language codes to Bureau Works locale codes via TMGMT remote language mappings.
- Send content preview URLs to Bureau Works translators so they can see the source in context.
- Use a configured public "Preview Base URL" when the site sits behind a load balancer or non-public hostname.
- Export job content as XLIFF with CDATA encoding for safe round-tripping of markup.
- Cancel a Bureau Works project automatically when a Drupal-side submission fails mid-setup.
- Abort a (non-continuous) TMGMT job and have the corresponding Bureau Works project cancelled.
- Show the Bureau Works project name in a Views-based TMGMT job-item listing (`bw_project_name`).
- Show the last delivered workflow stage and fetch time in a Views listing (`bw_last_workflow_delivered`).
- Assign multiple Bureau Works workflow stages (TRANSLATION, REVIEW, REVIEW_2, …) per provider configuration.
- Use sandbox-mode simulate actions ("Simulate complete", "Simulate preview") during integration testing.
- Deduplicate and rate-limit continuous re-queues so a burst of edits does not spam the translation queue.
- Handle enterprise localization workflows where content updates frequently and must stay in sync across languages.
- Let content editors work entirely inside the familiar TMGMT UI while a translation agency fulfils the work.
