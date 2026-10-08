<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform JSON Schema (webform_headless) exposes Webform to decoupled frontends: JSON endpoints return a form as a structured schema (FormKit or JsonForms) with default values, and let a client create, read and update submissions and upload files.
---
Each webform can be fetched as a schema via `GET /webform/{webform}/json/schema` (schema plugin selected by `?schema=`, e.g. `form_kit`), its settings via `.../json/settings`, and submissions managed via `POST .../json/submission`, `PATCH .../json/submission/{submission}`, `GET .../json/submission/{submission}` and file uploads via `POST .../json/upload`. Submission creation and updates run the data through the real `WebformSubmissionForm` in an "api" form mode, so the module's normal validation, conditions and (crucially) spam/handler protections execute exactly as they do for a browser POST; the `Referer` header is recorded as the "submitted to" source via the `url_entity` extractor. A pluggable schema layer (`WebformJsonSchema` plugins: `FormKit`, `JsonForms`) normalizes/denormalizes between JSON and webform element data, and a JSON exception subscriber renders errors as structured JSON.

Access control is delegated to Webform's own entity/operation permissions rather than being loosened: schema/settings require `webform.view`, upload and create require `webform.submission_create`, update requires `submission.update`, and reading a submission requires `submission.view` (with an extra check that the submission belongs to the addressed webform). There is no `_access: 'TRUE'` or blanket-anonymous endpoint — anonymous submission is only possible where the webform itself grants anonymous `create submission`, matching core Webform behaviour, and the same honeypot/CAPTCHA/validation handlers apply. The optional `webform_headless_ui` submodule adds an admin JSON-Forms inspection page (`access json forms ui`). Setup: enable the module (and `url_entity`), then call the endpoints per webform machine name.
---
- Fetch a webform as a FormKit schema: `GET /webform/{id}/json/schema?schema=form_kit`.
- Fetch a webform as a JsonForms schema.
- Retrieve default values alongside the schema.
- Fetch a webform's confirmation/settings JSON.
- Create a submission: `POST /webform/{id}/json/submission`.
- Submit as form-encoded or JSON payloads.
- Update an existing submission: `PATCH .../json/submission/{sid}`.
- Read a submission back by UUID/entity: `GET .../json/submission/{sid}`.
- Upload files for a file element: `POST .../json/upload`.
- Associate uploaded file IDs with a later submission.
- Save a submission as a draft via `?draft=1` (where drafts are enabled).
- Record the referring page as the submission's "submitted to" source.
- Receive structured validation errors keyed by field path.
- Get the confirmation type/URL/message back after a create/update.
- Build a decoupled (React/Vue/FormKit) frontend against Drupal webforms.
- Preserve webform spam protection (honeypot/CAPTCHA) on headless submits.
- Inspect a webform's JSON Forms output via the admin UI submodule.
- Add a new schema format by implementing a `WebformJsonSchema` plugin.