<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lionbridge Translation Provider adds a Lionbridge Content API translator to TMGMT, so translation jobs created in Drupal are exported as XLIFF, submitted to the Lionbridge service for professional (human) translation, and the finished translations are pulled back into the same TMGMT review-and-accept workflow. The 9.5.x line adds optional Auto-Bundle grouping and continuous-job handling on top of that.

---

TMGMT (Translation Management Tool) is Drupal's translation-management framework — jobs, job items, review and acceptance — with one translator plugin per service; this project supplies the Lionbridge one. The first thing to know is that the **project is `lionbridge_translation_provider` but the shipped, installable module is `tmgmt_contentapi`** (the only info file in the package), and its TMGMT plugin id is `contentapi`, so `drush en lionbridge_translation_provider` fails while `drush en tmgmt_contentapi` works. There is no settings page of its own: you add a translator of type "Lionbridge Content API Connector" under TMGMT's translator collection and enter the Client ID, Client Secret, and host there, then pick a provider fetched live from the API. Submission runs through Drupal queues (export → generate XLIFF → send files), which post source files to the Content API and record each request in a local `tmgmt_capi_request_processor` table. Retrieval is poll-based: `hook_cron` asks the API for status updates, downloads completed files, and imports them; there is no inbound webhook. Completed translations flow through TMGMT's normal XLIFF import and reviewer acceptance, and accepting or rejecting an item calls the Content API's approve/reject request endpoints. New in 9.5.x: an **Auto-Bundle** tab on each translator that automatically groups queued single-item translations into larger bundles by dimensions (content type, priority tier) and flushes them when word-count / item-count / wait-time triggers fire, with a live status panel; **continuous-job** support with a "Submissions" tab, duplicate-pair guarding, a re-queue suppressor, and an optional workflow-state gate that only creates translation jobs once content reaches required moderation states. The module also ships config schema for these settings (`auto_bundle`, `continuous_settings`) for the first time. An optional "Analysis Code" feature integrates with the Lionbridge Freeway SOAP API for per-job billing codes. This is vendor integration, not machine translation: jobs go to human translators under a commercial contract with an account and a per-word cost.

---

- Send TMGMT translation jobs to Lionbridge for professional translation.
- Use human translators instead of machine translation for quality-critical content.
- Manage vendor translation entirely from inside Drupal.
- Export content as XLIFF (with optional extended XLIFF/CDATA processing) for translation.
- Select a Lionbridge provider and see its supported source/target language pairs.
- Request a quote before translation begins where the provider supports it.
- Track remote job status and statistics on the TMGMT job detail page.
- Auto-import completed translations on cron, or import manually.
- Manually upload a returned `.xlf` or `.zip` translation file to import.
- Review, accept, or reject each translated item, syncing approve/reject to Lionbridge.
- Attach a PO number / PO reference and a due date to each job.
- Batch large jobs through queues that keep working across cron runs.
- Process a specific queue in the background via a permission-gated POST endpoint.
- Show queue backlog to editors with the Queue Status block.
- Add per-job Freeway analysis (billing) codes.
- Auto-bundle many single-item submissions into fewer, larger Lionbridge jobs to cut per-job overhead.
- Group auto-bundles by content type and/or a priority-tier field, with a live group-key preview.
- Flush bundles on word-count, item-count, or maximum-wait triggers, with per-bundle item/word caps and a minimum-items floor.
- Watch bundle backlog and blockers in a right-side Auto-Bundle status panel.
- Run continuous translation jobs that pick up new/changed content over time.
- Gate continuous job creation on required content-moderation states (workflow gate).
- See all submissions spawned by a continuous job on a dedicated "Submissions" tab.
- Combine vendor translation with machine translation by routing languages to different translators.
- Reconcile vendor costs against jobs via PO references.
- Clean up remote job files and connector records when a TMGMT job is deleted.
- Support a large, ongoing localisation programme with a single connector.
