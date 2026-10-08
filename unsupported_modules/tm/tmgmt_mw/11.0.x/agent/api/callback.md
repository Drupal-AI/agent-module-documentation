<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MotaWord callback & API surface

## Callback route
`POST /tmgmt_mw_callback` (`tmgmt_mw.callback`, `_access: 'TRUE'`) — `MwController::callback`.

Request params: `type`, `action`, `project` (object; must contain `project.custom.job_id`). Flow:
- Validates presence of `type`/`action`/`project` and `custom.job_id`; loads the local `Job`.
- On `type=project` / `action=completed`: logs, adds a job message, calls `$mw->retrieveTranslation($job)` then `setState(STATE_FINISHED)`.
- `translated` / `proofread` actions only add informational job messages.

**Sound content pattern:** `retrieveTranslation()` (`MwTranslator.php:481`) calls `$api->downloadProject((int) $job->getReference())` — the project id comes from the job's stored reference, and the translation is downloaded over the OAuth-authenticated MotaWord API, not read from the callback body. The in-code comment (line 482) says this is deliberate "to avoid spam through the callback".

**Observation:** no signature/token check on the callback, and `job_id` is attacker-supplied, so an unauthenticated request can force a fetch + state transition for any job id.

## API client (`MwApi`)
- Endpoints: `https://api.motaword.com` (prod) / `https://sandbox.motaword.com`.
- Auth: OAuth `client_id`/`client_secret` (translator settings) → `POST /token`; access token + expiry cached in `$_SESSION`.
- Methods: `getLanguages`, `getProject`, `getProgress`, `getAccount`, `submitProject`, `downloadProject`, `launchProject`. All requests use Guzzle with the `access_token` query param.
