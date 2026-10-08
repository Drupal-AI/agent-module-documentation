<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Transifex Connector integrates TMGMT with the Transifex localization platform, pushing source resources to Transifex and pulling translations back — including a webhook so Transifex can notify Drupal when translations are updated. Configured under the translator collection.

---

The TransifexTranslator plugin syncs resources/translations with Transifex's API, and a route /tmgmt_transifex_callback (TransifexController::callback) receives Transifex webhooks. The callback reads the raw request body and verifies a Transifex HMAC-SHA256 signature: it recomputes base64(hmac_sha256(POST\n{url}\n{date}\n{md5(body)}, secret)) using the translator's stored secret and compares it to the X-Tx-Signature-V2 header, rejecting the request if the secret is unset, required headers are missing, or the signature does not match. Only on a valid signature does it call updateJobWithTranslations.

Use it for continuous localization with Transifex as the TMS. The webhook secret is stored in the translator settings and must match Transifex's configuration for updates to be accepted.

---

- Sync TMGMT resources with Transifex.
- Push source content to Transifex.
- Pull completed translations back.
- Receive translation-updated webhooks.
- Verify webhooks with an HMAC-SHA256 signature.
- Reject webhooks with a missing/invalid signature.
- Require required X-Tx headers on callbacks.
- Store the webhook secret in translator settings.
- Configure via Translation providers UI.
- Support continuous localization workflows.
- Map Drupal languages to Transifex languages.
- Update jobs automatically on valid webhooks.
- Drive translation through the TMGMT flow.
- Integrate Transifex as the TMS.
- Handle resource/language events.
- Keep webhook processing authenticated.
- Fit large multilingual sites.
- Automate translation refreshes.
