<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto-Bundle, continuous jobs, and the workflow gate (new in 9.5.x)

These three related features are new on the 9.5.x line. All of their settings persist on the
**translator** config entity (`tmgmt.translator.contentapi`) under `settings.auto_bundle` and
`settings.continuous_settings`, declared in
`config/schema/tmgmt_contentapi.translator.schema.yml`.

## Auto-Bundle

Auto-Bundle groups many small queued translation submissions into fewer, larger Lionbridge jobs
to cut per-job overhead. It is configured on a dedicated tab:

- **Form route:** `tmgmt_contentapi.translator_auto_bundle` →
  `/admin/tmgmt/translators/manage/{tmgmt_translator}/auto-bundle` (`Form\AutoBundleForm`), shown
  as the **Auto-Bundle** local task next to the translator Edit tab.
- **Status route:** `tmgmt_contentapi.auto_bundle_status_refresh` →
  `.../auto-bundle/status` (`Controller\AutoBundleStatusController::refresh`, `no_cache`), an AJAX
  endpoint that re-renders the right-side status panel.
- **Access (both):** `AutoBundleForm::access()` — allowed only when the translator's plugin id is
  `contentapi` **and** the account has `update` access to that translator entity. The status
  controller delegates to the same check.

### Settings (`settings.auto_bundle`)

| Key | Type | Meaning |
|---|---|---|
| `auto_bundle_enabled` | boolean | Master on/off switch. |
| `group_by_content_type` | boolean | Add content type as a grouping dimension (default TRUE). |
| `group_by_priority` | boolean | Add a priority-tier dimension (default FALSE). |
| `priority_field` | string | Field machine name supplying the priority tier. |
| `priority_empty_fallback` | string | `normal` \| `low` \| `skip` when the field is empty. |
| `trigger_word_count` | integer | Flush when accumulated words reach this (default 5000). |
| `trigger_item_count` | integer | Flush when accumulated items reach this (default 10). |
| `trigger_max_wait_seconds` | integer | Flush when the oldest item waits this long (default 86400). |
| `cap_max_items` | integer | Hard per-bundle item cap (default 50). |
| `cap_max_words` | integer | Hard per-bundle word cap (default 50000). |
| `cap_min_items` | integer | Minimum items required to flush (default 1). |
| `cap_wait_overrides_min_items` | boolean | Let the wait-time trigger override the min-items floor (default TRUE). |
| `submission_mode` | string | `immediate` \| `cron`. |
| `max_concurrent_submissions` | integer | Cap on simultaneous submissions. |

The priority-field picker is populated by `tmgmt_contentapi.priority_field_discovery`, which
enumerates `list_string` / `list_integer` fields on translatable bundles.

### Runtime

- `AutoBundleAccumulatorSubscriber` (event subscriber) records eligible queued items into the
  `tmgmt_contentapi_bundle_queue` install table, keyed by a group key from
  `AutoBundleGroupKeyBuilder`.
- On every `hook_cron`, `_tmgmt_contentapi_auto_bundle_cron_evaluate()` asks
  `AutoBundleTriggerEvaluator` which bundles are mature and `AutoBundleFlusher` (lock-guarded)
  turns each mature bundle into a real translation job via `tmgmt_contentapi.create_job`.
- The status panel is built by `AutoBundleStatusBuilder` (cards + blockers), with group keys
  rendered by `AutoBundleGroupKeyHumanizer`; the `auto-bundle-status` / `auto-bundle-form`
  libraries (`tmgmt_contentapi.libraries.yml`) supply the JS/CSS and a live group-key preview.

## Continuous jobs

TMGMT continuous jobs pick up new/changed content over time. 9.5.x adds:

- **`ContinuousJobService`** (`tmgmt_contentapi.continuous_job`) — orchestration plus
  `findDuplicateContinuousJob()`, used by `tmgmt_contentapi_duplicate_continuous_job_validate()`
  to block a second continuous job for the same source→target pair on the same provider.
- **`ContinuousJobFormHelper`** — adds activation controls to the job edit form.
- **`ContinuousReQueueSubscriber`** / **`ContinuousReQueueSuppressor`** — manage re-queuing of
  continuous sources without duplicate churn.
- **"Submissions" tab:** route `tmgmt_contentapi.continuous_submissions` →
  `/admin/tmgmt/jobs/{tmgmt_job}/submissions` (`ContinuousSubmissionsController::listSubmissions`).
  Access = job `isContinuous()` **and** `update` access to the job. It embeds the
  `tmgmt_job_overview` view filtered (via `hook_views_query_alter`) to jobs whose
  `reference` is stamped `continuous:<jid>`.

## Workflow-state gate

- **`WorkflowGateSubscriber`** (`tmgmt_contentapi.workflow_gate_subscriber`, event subscriber)
  blocks creation of translation jobs until the source content reaches one of the required
  content-moderation states.
- **Setting:** `settings.continuous_settings.workflow_states_required` — a sequence of
  moderation state ids. With no states configured the gate is inert.
