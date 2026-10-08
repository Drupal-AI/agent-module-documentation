Smartling Translator is a TMGMT (Translation Management Tool) provider plugin that connects Drupal to the [Smartling](https://www.smartling.com/) translation platform: it exports translatable content as XML/XLIFF, uploads it to a Smartling project via the Smartling PHP SDK, optionally captures visual context, and downloads finished translations back into TMGMT jobs (on a schedule, on Smartling callbacks, or on demand).

---

The module registers a TMGMT `Translator` plugin (`smartling`) plus its settings UI (`SmartlingTranslatorUi`). You configure a TMGMT provider with your Smartling **Project Id**, **User Id** and **Token Secret** (used by `smartling/api-sdk-php` v5 to authenticate), choose an export format (XML/XLIFF via `tmgmt_file`), and set options like auto-authorization, translatable/excluded HTML attributes, segmentation tags, custom placeholder regexp, async mode, per-job-item download, and remote logging/notifications. Uploads and downloads are queued through `tmgmt_extension_suit`'s `FlowScheduler` (`scheduleUpload`/`scheduleDownload`) and processed by cron/queues. Translations can be pulled back three ways: on a schedule, on demand via bulk actions/forms (`SendContextAction`, `DowloadByJobItemsJobAction`, the approve forms), or when Smartling calls back to `/tmgmt-smartling-callback/{job}` (and `/{job}/{file}`) — public callback routes that schedule a download for the job. The **context** feature renders the translated page (optionally logging in as a configured user via `ContextCurrentUserAuth`/`ContextUserAuth`, with optional basic-auth and host settings) and uploads the HTML so translators see in-context strings; sending context is gated by the `send context smartling` permission. A "progress tracker" (Firebase) surfaces health/status messages (`see smartling messages`). Two hidden helper submodules exist for Acquia Cohesion support and testing, plus `tmgmt_smartling_context_debug` (a context-debug form) and `tmgmt_smartling_log_settings` (per-channel log severity). A set of alter hooks (`tmgmt_smartling.api.php`) lets you customise context URLs, file names, upload directives, XML import/export data and the lock-fields form list. Configure providers under TMGMT: *Administration → Translation → Providers*.

---

- Send Drupal content to Smartling for professional/machine translation via TMGMT.
- Authenticate to a Smartling project with Project Id / User Id / Token Secret.
- Export content as XML or XLIFF for translation.
- Auto-authorize uploaded content for translation in Smartling.
- Pull completed translations back into TMGMT jobs automatically on cron.
- Trigger a translation download when Smartling calls the module's callback URL.
- Download and apply translations per job item rather than per whole job.
- Upload visual context (the rendered page) so translators see strings in place.
- Render context as a specific user (context user auth), optionally behind HTTP basic auth.
- Restrict/skip context host verification or override the context URL host.
- Bulk-send context for many job items via the "send context" action (permission-gated).
- Approve and download translations by job items through the provided admin forms.
- Define which HTML attributes are translatable (e.g. title, alt) and which to exclude.
- Segment translatable strings by specific HTML tags.
- Use a custom placeholder regular expression to protect tokens from translation.
- Run uploads/downloads asynchronously (async mode) through queues.
- Enable Smartling remote logging and real-time notifications.
- Debug the context feature with the context-debug submodule.
- Tune per-channel/log-severity via the log-settings submodule.
- Support Acquia Cohesion components with the (hidden) cohesion submodule.
- Alter the context URL per job item (`hook_tmgmt_smartling_context_url_alter`).
- Customise uploaded/attachment file names (`hook_tmgmt_smartling_filename_alter`).
- Set Smartling upload directives such as namespace or force-inline tags per job.
- Alter data on XML export/import to reshape what gets translated.
- Choose the file storage scheme (public/private) and retrieval type (published/pending).
- Integrate translation into an editorial workflow using TMGMT continuous jobs.
