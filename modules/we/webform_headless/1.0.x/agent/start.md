<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform JSON Schema (webform_headless) — agent index
**Headless Webform API: JSON endpoints to fetch a form as a FormKit/JsonForms schema and to create/read/update submissions and upload files.**

- **Version:** 1.0.x (release 1.0.0-alpha3)
- **Core:** ^10.2 || ^11 · **PHP:** 8.1
- **Dependencies:** file, webform, url_entity. Submodule: `webform_headless_ui`.
- **Routes** (all `_format: json`, per-webform): schema/settings `GET` require `_entity_access: webform.view`; `POST .../json/upload` & `POST .../json/submission` require `webform.submission_create`; `PATCH .../json/submission/{submission}` requires `submission.update`; `GET .../json/submission/{submission}` requires `submission.view`.
- **Services:** `webform_headless.submitter` (`Submitter`), `plugin.manager.webform_headless` (schema plugins `FormKit`, `JsonForms`), `webform_headless.file_uploader`, JSON exception subscriber.
- **Security:** every endpoint is gated by Webform's native entity/operation access — no `_access: 'TRUE'`, no blanket-anonymous route. Submissions go through the real `WebformSubmissionForm` (api mode), so validation + honeypot/CAPTCHA/handlers run as normal; `isOpen()` is enforced. `GetSubmission` also verifies the submission belongs to the addressed webform. Anonymous posting is possible only where the webform grants anonymous create, matching core Webform. No submission leak, no disabled TLS, no raw SQL. Submodule UI page gated by `access json forms ui`.

See [api/endpoints.md](api/endpoints.md)
