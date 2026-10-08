<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A GearTranslations translator plugin for TMGMT.

---

GearTranslations Translator is a GearTranslations integration plugin for TMGMT (Translation Management Tool) — so translation jobs can be sent to the GearTranslations service and completed translations imported back into Drupal.

**Security warnings (as shipped, 8.x-1.3):** (1) the callback `/tmgmt_geartranslations_callback` is `_access: 'TRUE'` and imports the posted `texts` into any active job with **no signature/authenticity check** — an anonymous caller who supplies an active `job_id` can inject arbitrary translated content (content injection / potential stored XSS). (2) The API connector sets `CURLOPT_SSL_VERIFYPEER=false`, sending the `Access-Token` credential over an unverified TLS connection (MITM). **Verify the callback signature and enable TLS verification.** The GearTranslations API token is admin-configured; store it securely (env-backed). Depends on `tmgmt` and `tmgmt_content`; supports Drupal 8 and later.

---

- Send jobs to GearTranslations.
- Import completed translations.
- Integrate with TMGMT.
- Provide a translator plugin.
- WARNING: callback verifies no signature.
- WARNING: TLS verification disabled.
- Verify callback signatures.
- Enable TLS verification.
- Depend on `tmgmt` and `tmgmt_content`.
- Store the API token securely.
- Handle GearTranslations.
- Translate content.
- Support Drupal.
- Support Drupal.
- Support Drupal.
