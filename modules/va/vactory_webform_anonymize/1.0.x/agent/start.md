<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vactory Webform Anonymize — agent orientation

Role-based anonymization of webform submissions on display + export/edit blocking.

- Version 1.0.x, core ^9||^10, deps webform.
- `hook_entity_view_alter` masks submission data via `vactory_webform_anonymize.helper`; list builder swapped to `AnonymizedWebformSubmissionListBuilder`; `hook_preprocess_page` throws AccessDenied on export/edit routes when `shouldAnonymize()`.
- Settings `/admin/structure/webform/manage/{webform}/anonymize` gated `administer webform`.
- Protective module; no anonymous routes, no HTTP calls. Note: enforcement is at display/route level, not storage. Nothing exploitable found.
