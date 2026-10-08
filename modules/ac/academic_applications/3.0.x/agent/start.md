<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Academic Applications (academic_applications) — agent index
**Bundles Webform application answers and reference-letter PDFs into one PDF via a workflow config entity and GhostScript.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10 || ^11
- **Requires:** webform, GhostScript (`gs`) binary, private file system
- **Config entity:** `academic_applications_workflow` (links application form → letters form)
- **Routes:** `academic_applications.settings_form` (`_permission: access academic applications`); `entity.webform_submission.bundle` (`_entity_access: webform_submission.view`)
- **Permissions:** `administer academic applications` (declared; note the settings route references `access academic applications`, which is not declared → fails closed)
- **Services:** `academic_applications.workflow_connector`, `.submission_bundler`, `.submission_pdf_finder`
- **Security:** Bundle route is entity-access gated; recommendation-form access depends on the secrecy of the submission UUID in the `wt` query parameter; no anonymous mutating endpoints. Recommendation PDFs must live in private storage.

See [configure/workflows.md](configure/workflows.md)