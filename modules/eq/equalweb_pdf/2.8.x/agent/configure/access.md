<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EqualWeb PDF — access model & endpoints

## One route, per-action authorization
`/equalweb-pdf/ajax/{action}` (POST) → `AjaxController::handle()`:
1. Validate `equalweb_pdf` CSRF token (from `token` body or `X-EQW-Token` header) → 403 on failure. **Anti-CSRF only, never authorization.**
2. Look up `Access::ACTION_PERMS[$action]`; NULL = view is enough, string = that permission, array = ANY of them (e.g. `poll` accepts check OR remediate).
3. Dispatch to `do<Action>()`.

`ACTION_PERMS`: check→`check equalweb pdf files`; poll→[check,remediate]; report→NULL; remediate→`remediate equalweb pdf files`; apply/restore→`replace equalweb pdf files`; save_settings/balance/register + all `cls_*` classification actions→`administer equalweb pdf`.

## File-scope helper (`Access`)
- `view any equalweb pdf files` → sees all files.
- `view own equalweb pdf files` → only files where `file->getOwnerId() === currentUser` (`canSee()`).
- `administer equalweb pdf` short-circuits every check (`can()`); core admins bypass natively.
- `caps()` exposes cosmetic booleans to drupalSettings — server re-checks every action.

## Download / report
- `/equalweb-pdf/download/{fid}` (GET): CSRF-token validated, then `Access::canSee($file)` + `rem_doc_id` present, else `NotFoundHttpException` (scope failures 404 like nonexistent — no oracle). Streams a temp file fetched from EqualWeb; `deleteFileAfterSend(TRUE)`.
- `/equalweb-pdf/report/{year}` (GET): `_csrf_token: 'TRUE'`; report data scoped through `AdminController::pdfFiles()` so own-scope users see only aggregates over their own files.

## Public verify handshake
`/equalweb-pdf/verify` (GET, `_access: 'TRUE'`) → `VerifyController::verify()`: returns `{nonce}` from `state('equalweb_pdf.reg_nonce')` only when present and unexpired, else `{error}` 404; `Cache-Control: no-store`. Side-effect-free, no request data read, no server-side fetch → not abusable for forged verification or SSRF. The nonce is generated server-side and the EqualWeb proxy reads it to confirm site ownership during registration.
