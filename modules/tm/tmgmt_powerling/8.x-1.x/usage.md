<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Powerling Translation Provider adds a TMGMT translator plugin so content submitted through Translation Management Tool is routed to Powerling's professional human translators and returned into Drupal automatically.

---

Jobs are exported as files (depends on `tmgmt_file`) and uploaded to the Powerling API by `PowerlingTranslator`, which authenticates every request with a `Bearer` token from the translator settings over HTTPS. Two anonymous callback routes let Powerling notify the site when work progresses: `/tmgmt_powerling/callback/order/{tmgmt_job}/{order_id}` and `/tmgmt_powerling/callback/file/{tmgmt_job_item}/{order_id}/{file_id}` (both `_access: 'TRUE'`). Crucially the callbacks do **not** trust the request body: the order callback calls `getOrder()` to re-fetch order status from the Powerling API, and the file callback calls `updateTranslation()` to re-pull the translated file from Powerling — the request only acts as a "come fetch updates" trigger. Each callback also verifies the referenced job's translator plugin is actually `PowerlingTranslator` before doing anything.

Security review: this is the sound webhook pattern — no state is mutated from attacker-supplied data; the module re-fetches everything from Powerling over the authenticated Bearer channel (`PowerlingTranslator.php:273`), and TLS is left at Guzzle defaults (not disabled). The only residual is that an attacker who guesses a valid job + order id could trigger a redundant authenticated re-fetch (a low-impact poll), not data injection. Setup: obtain a Powerling token, add a TMGMT translator using this plugin, enter the token/endpoint, then submit jobs.

---
- Send Drupal content to Powerling for professional translation.
- Configure a TMGMT translator with a Powerling Bearer token.
- Submit a translation job to Powerling from the TMGMT UI.
- Receive order-status updates via the order callback.
- Auto-pull completed translations via the file callback.
- Abort a Drupal job when Powerling reports the order canceled.
- Translate entity fields, taxonomy and other content types.
- Export job items as translatable files (XLIFF/HTML via tmgmt_file).
- Track per-file translation status.
- Map Drupal languages to Powerling language codes.
- Re-fetch order status on demand from the Powerling API.
- Keep translations in sync without manual import/export.
- Log translation communication errors.
- Restrict who can configure the translator via TMGMT permissions.
- Request an estimate/token from Powerling before use.
- Handle multi-item jobs with per-item callbacks.
