<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MotaWord translator (tmgmt_mw) — agent index
**TMGMT provider plugin submitting jobs to MotaWord and re-fetching finished translations over an authenticated API channel.**

- **Version:** 11.0.x (project `tmgmt_motaword`) — core `^8 || ^9 || ^10`
- **Depends on:** tmgmt, tmgmt_file
- **Plugin:** `@TranslatorPlugin(id="mw")` `MwTranslator`; API client `MwApi` (OAuth client id/secret, token cached in `$_SESSION`)
- **Route:** `tmgmt_mw.callback` `/tmgmt_mw_callback` — `_access: 'TRUE'` (unauthenticated)
- **Security:** callback is unauthenticated and reads `job_id` from the request, BUT it re-fetches the authoritative translation from the MotaWord API by the job's stored project reference (`MwController.php` → `MwTranslator::retrieveTranslation` line 485) — request body content is NOT trusted. Residual: an anonymous caller can trigger a re-fetch / `STATE_FINISHED` transition for an arbitrary local job id (state-manipulation / API-call trigger), not content injection.

See [api/callback.md](api/callback.md).
