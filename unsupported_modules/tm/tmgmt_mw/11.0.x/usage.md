<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MotaWord translator is a TMGMT (Translation Management Tool) provider plugin that sends translation jobs to the MotaWord human-translation service and pulls the finished translations back into Drupal.

---

The plugin (`MwTranslator`, id `mw`) authenticates to the MotaWord API (`MwApi`) with an OAuth client id/secret (stored as translator settings), obtaining an access token cached in the PHP session. It submits job content, tracks project progress, and retrieves the translated data. A public callback route `/tmgmt_mw_callback` (`_access: 'TRUE'`) receives project status notifications (`type`, `action`, `project`); on `completed` it does NOT trust the request body for content — it calls `retrieveTranslation()`, which re-downloads the authoritative translation from the MotaWord API using the job's stored project reference (`MwController.php` comments "to avoid spam through the callback"). Because the callback is unauthenticated and the `job_id` is taken from the request body, a caller can trigger a re-fetch / state transition for an arbitrary local job id, but injected content is not accepted.

Setup: add a MotaWord translator provider under TMGMT, enter API client id/secret, and (optionally) point MotaWord's webhook at `/tmgmt_mw_callback`. Requires tmgmt and tmgmt_file.
---
- Create a TMGMT translator using the MotaWord provider
- Enter MotaWord API client id and secret in the provider settings
- Switch between production and sandbox MotaWord endpoints
- Submit a translation job to MotaWord
- Request a quote before launching a project
- Check project progress from the provider UI
- Retrieve finished translations into TMGMT jobs
- Receive MotaWord status callbacks at /tmgmt_mw_callback
- Auto-finalize a job when MotaWord reports completion
- Parse JSON, XML or ZIP translation payloads from the API
- Map Drupal language codes to MotaWord language codes
- View account details from the API
- Use tmgmt_file for file-based job data
- Handle proofread/translated intermediate states as job messages
- Integrate human translation into a Drupal localization workflow
- Restrict who can configure the translator via TMGMT permissions
