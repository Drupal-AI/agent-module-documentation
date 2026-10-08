<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BLEND translator integrates TMGMT with the BLEND / getBlend (formerly One Hour Translation, OHT) professional translation service. It submits TMGMT jobs, discovers supported languages/expertise, quotes, and receives completed translations via a callback route.

---

The OhtTranslator plugin talks to the BLEND API over the core http_client, using public/secret API keys from the translator settings and caching discovery calls (languages, language pairs, expertise). An inbound route /tmgmt_oht_callback (OhtController::callback) is notified when translations are ready or a project is cancelled.

The callback verifies authenticity by requiring request parameter custom1 to equal OhtTranslator::hash(job_item_id), where hash() = md5(site hash salt . id). Because the hash salt is a site secret, an external party cannot forge the token, so the callback is bound to values the site itself issued. It then retrieves the translation for the referenced job item, or aborts it on cancellation. Use it for professional human translation through the TMGMT UI; credentials live in the translator settings.

---

- Submit TMGMT jobs to BLEND/getBlend.
- Retrieve completed translations via callback.
- Discover supported languages and pairs.
- Discover translation expertise codes.
- Quote jobs before submission.
- Authenticate with BLEND public/secret keys.
- Cache discovery API responses.
- Verify callbacks with a hash-salt token.
- Abort job items when a project is cancelled.
- Package source content via tmgmt_file.
- Configure via Translation providers UI.
- Drive human translation through TMGMT.
- Map languages to BLEND codes.
- Handle project comments.
- Support professional LSP workflows.
- Store credentials in the translator entity.
- Use Guzzle with default TLS verification.
- Fit multilingual content operations.
