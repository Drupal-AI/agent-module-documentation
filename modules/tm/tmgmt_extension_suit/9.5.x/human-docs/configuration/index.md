# Configuration

TMGMT Extension Suit is configured on one settings form, plus the bulk actions it
adds to the job overview. Everything requires TMGMT's **Administer tmgmt**
permission.

## Open the settings form

Go to **Administration → Translation → Settings** and open the module's tab, or
navigate directly to `/admin/tmgmt/extension-settings`.

### Track changes (global switch)

- **Track changes** — the master on/off switch for automatically re-submitting
  content for translation when its source is edited. It is stored in
  configuration and defaults to **on**.

When it is on, editing a source entity that already has active or finished
translation jobs is detected (via a per-job-item content hash): the module resets
the affected job item, reopens the job, and re-queues it for upload — keeping the
translation in sync without anyone re-sending it by hand.

### Per translator + target language

Below the master switch, for each configured TMGMT translator whose plugin
supports the extended interface, you get a group of **per-language checkboxes**.
These let you scope automatic re-submission to specific provider + target-language
combinations — so you can, for example, auto-resync French through one provider but
not German.

- These per-provider/language choices are stored in Drupal **state** (not exported
  config).
- If none of your configured translators support the extended interface, the form
  shows a warning — nothing here will apply until you have a compatible
  translator.

Save the form to apply your choices.

## The cron queues (background upload/download)

The module adds two cron queue workers so translation traffic runs in the
background instead of blocking a request:

- **Upload queue** — sends jobs (requests translation) to the provider.
- **Download queue** — fetches and applies completed translations, including
  attachment files.

Both are processed when Drupal cron runs, and a scheduler de-duplicates queued
items so the same job isn't processed twice. Make sure cron runs on a regular
schedule.

## Bulk actions on the job overview

On the TMGMT **Jobs** overview (`admin/tmgmt/jobs`) the module adds a
bulk-operations form with five actions. Select jobs, choose an action, and confirm
it on the approval page that follows:

| Action | What it does |
|---|---|
| **Request Translation** | Queue the selected jobs for upload to the provider. |
| **Download Translation** | Queue the selected jobs for download and apply their translations. |
| **Cancel Job** | Cancel the selected jobs (also cancelling in the third-party service). |
| **Delete Job** | Delete the selected jobs. |
| **Clear JobItem data** | Clear the cached job-item data to reclaim space or force a refresh. |

Each action routes through its own confirmation form (under
`/admin/tmgmt/extension-approve-action-*`) before it runs, and all of them require
**Administer tmgmt**.

## Other behavior worth knowing

- Every translation job gets a generated, deterministic **file name** (provided by
  the translator plugin) via an added `job_file_name` field.
- The module removes `moderation_state` from the set of translatable fields sent
  to translation, so workflow state isn't shipped off to translators.
- Developers can react to jobs that were reopened by track-changes via the
  `hook_tmgmt_extension_suit_updated_entity_jobs` hook — see the
  [`agent/`](../agent/start.md) docs.
