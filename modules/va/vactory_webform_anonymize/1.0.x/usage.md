<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vactory Webform Anonymize

Masks webform submission values when viewed by users in configured roles, and prevents export/edit of submissions where anonymization is active, so sensitive submission data is not exposed to certain privileged roles.

- Per-webform anonymization settings (third-party settings).
- Anonymizes submission values on view.
- Swaps the submission list builder to an anonymized one.
- Blocks results-export and submission-edit when anonymizing.

---

# Installing & configuring

- Require and enable with Webform (`drush en vactory_webform_anonymize`).
- Configure per webform at `/admin/structure/webform/manage/{webform}/anonymize`.
- The settings form requires `administer webform`.
- Settings are stored as webform third-party settings.
- An "Anonymize Settings" operation appears on webforms for `administer webform`.

---

# Usage & behaviour

- `hook_entity_view_alter` anonymizes submission `data` when `shouldAnonymize()` is true.
- Structural keys (sid, uuid, operations, etc.) are skipped during anonymization.
- The helper service `anonymizeRecursive()` masks values per settings and view mode.
- The submission list builder is replaced with `AnonymizedWebformSubmissionListBuilder`.
- `hook_preprocess_page` throws AccessDenied on results-export and submission-edit routes when anonymizing.
- The export local task is unset from the submissions tab when anonymizing.
- Anonymization is decided by role via `shouldAnonymize($webform)`.
- Table and text view modes are handled distinctly.
- The module protects PII from roles that can otherwise view submissions.
- Only the settings form and per-webform operation are added as routes.
- The settings route is gated by `administer webform`.
- No anonymous-facing endpoints are exposed.
- No external services or HTTP calls are made.
- Uninstalling restores the default list builder and view.
- Anonymization is display/route enforcement, not storage-level redaction.
- Useful for GDPR-style limiting of who sees raw submission data.
