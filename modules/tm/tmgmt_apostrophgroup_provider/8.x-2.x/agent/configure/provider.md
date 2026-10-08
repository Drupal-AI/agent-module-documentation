<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apostroph translator — configuration & flow

## Add the provider
TMGMT → Providers → add a translator using **Apostroph Group Connector**.
`apostroph-settings`:
- `url` — myApostroph REST base URL (HTTPS).
- `username` / `password` — HTTP Basic credentials (sent as `Authorization: Basic base64(user:pass)`).
- `customer_id` — Apos customer number for order routing.
Other settings: `one_export_file` (bool), `scheme` (`public`|`private`, default `public`), `is_confidential`, `cron-settings.status`.

## Send flow (`ApostrophTranslator::requestTranslation`)
1. Export job (or each item) to XLIFF via `AXliff`.
2. Zip into `<scheme>://tmgmt_apostrophgroup/ApostrophSentFiles/...`.
3. `Configuration->setHost/Username/Password`; `TranslationApi::createnewTranslation()` (3 retries).
4. Store returned translation id as job `reference`; surface a download link message.

## Import flow
- Cron (`..._cron` → `..._downlaod_data_by_translator`) or semi-import form submit → `..._downlaod_data_by_job`.
- 204 = no delivery; 200 = base64-decode → gunzip (`extact_gzip_file`) → XLIFF import with job-id match check.

## Security checklist for operators
- Set `scheme` to `private` for any confidential content — `public` exposes source ZIP/XLIFF and the status-message download URL.
- Treat exported TMGMT config as secret (credentials are stored plaintext there).
- No inbound endpoint exists; all provider communication is initiated by Drupal over HTTPS with TLS verification on.
