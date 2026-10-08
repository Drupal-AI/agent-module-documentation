MemoQ translator is a TMGMT (Translation Management Tool) provider plugin that connects Drupal's translation jobs to a memoQ server's CMS API, sending source content as XLIFF and pulling completed translations back. It requires the `tmgmt` and `tmgmt_file` modules.

---

The module registers a single TMGMT translator plugin (`tmgmt_memoq`) whose settings — memoQ **CMS API URL**, **API key**, an order name prefix, per-language code mappings, and XLIFF processing/CDATA toggles — are stored on a TMGMT `translator` config entity (there is no standalone settings page; you add a "MemoQ" translator under `admin/tmgmt/translators`). On request (`requestTranslation`), it creates a memoQ **order**, exports each job item to gzipped XLIFF via the `tmgmt_file` "xlf" format, uploads it as a memoQ job, stores memoQ ids in TMGMT `RemoteMapping` entities, and commits the order; every outbound call goes to the configured `api_url` with an `Authorization: CMSGATEWAY-API <api_key>` header. Completed translations are retrieved two ways: a memoQ-initiated **callback** at `/tmgmt/memoqcallback/{tmgmt_job}` (`MemoQController`) that, on a `TranslationReady` status, looks up the remote mapping and imports the translated XLIFF; and a pull-style `fetchJobs()` that queries the order's jobs and imports any that are ready. Two alter hooks (`hook_tmgmt_memoq_order_info_alter`, `hook_tmgmt_memoq_job_info_alter`) let other modules tweak the order/job payloads before submission. Extended XLIFF processing masks HTML tags rather than escaping them, and a CDATA option controls XLIFF import/export encoding.

---

- Send Drupal content translation jobs to a memoQ server for professional translation.
- Configure a memoQ translation provider inside TMGMT (`admin/tmgmt/translators`).
- Store the memoQ CMS API URL and API key on a TMGMT translator entity.
- Map each Drupal language to its memoQ language code.
- Prefix memoQ order names with a fixed string for easier identification.
- Export job items to XLIFF and upload them (gzipped) to a memoQ order.
- Create and commit a memoQ order automatically when a TMGMT job is submitted.
- Receive completed translations automatically via the memoQ callback webhook.
- Pull ready translations on demand with the plugin's `fetchJobs()`.
- Import translated XLIFF back into the originating TMGMT job.
- Test connectivity to memoQ from the translator settings form (Connect button).
- Set a per-job deadline that is passed to the memoQ order.
- Use extended XLIFF processing to mask HTML tags instead of escaping them.
- Toggle CDATA usage for XLIFF import/export to suit the memoQ workflow.
- Add the word count to the order name via `hook_tmgmt_memoq_order_info_alter()`.
- Prepend the job owner's name to a memoQ job via `hook_tmgmt_memoq_job_info_alter()`.
- Track Drupal job ↔ memoQ order/job links through TMGMT RemoteMapping entities.
- Route all memoQ traffic through a self-hosted CMS API gateway URL.
- Localize a multilingual Drupal site using an external memoQ translation team.
- Integrate an existing memoQ TMS into a Drupal content workflow.
- Override memoQ credentials per environment via TMGMT config overrides in settings.php.
