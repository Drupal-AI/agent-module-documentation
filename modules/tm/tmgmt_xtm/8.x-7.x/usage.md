<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT XTM is a Translation Management Tool provider that connects Drupal to the XTM Cloud translation platform, sending content out for translation and importing the results.

---

The translator plugin (`XtmTranslator` and the `Connector` family under `src/Plugin/tmgmt/Translator/`) exchanges files with XTM (via its API / SOAP MTOM services) and maps TMGMT jobs and job items to XTM projects. A public callback route `/tmgmt_xtm_callback` (`_access: 'TRUE'`) is invoked by XTM when a project changes state: `RemoteCallbackController::callback` reads `xtmProjectId` and the TMGMT job ids from the request, sanitizes them to integers, and enqueues them onto the `callback_job_queue`. The queue worker (`JobQueue`) later processes each item — it loads the local job, and crucially rejects the item unless the callback's `xtmProjectId` equals the job's stored XTM reference (`isInvalidProjectInJob()`), then re-downloads the translation from XTM over the site's authenticated API channel. The callback body is therefore not trusted for content, and cross-project injection is blocked by the reference check.

Setup: add an XTM translator under TMGMT (`/admin/tmgmt/translators`), configure XTM credentials/endpoint, and register `/tmgmt_xtm_callback` as the XTM callback URL. Requires tmgmt.
---
- Create a TMGMT translator using the XTM provider
- Configure XTM API credentials and endpoint
- Send TMGMT jobs to XTM Cloud for translation
- Support multiple target languages per job
- Handle continuous translation jobs
- Receive XTM state-change callbacks at /tmgmt_xtm_callback
- Queue callback work onto callback_job_queue for cron processing
- Re-download translations from XTM authoritatively on callback
- Reject callbacks whose project id does not match the job reference
- Abort individual XTM job items
- Edit XTM job settings
- Map job items to XTM project references
- Use SOAP/MTOM file transfer with XTM
- Import translated files back into TMGMT job items
- Process the callback queue on cron (hourly)
- Restrict translator configuration via TMGMT permissions
