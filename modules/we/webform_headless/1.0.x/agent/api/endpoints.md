<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform JSON Schema — REST endpoints

All routes are per-webform, JSON only, and access is delegated to Webform's own entity access.

| Method & path | Controller | Access requirement |
|---|---|---|
| `GET /webform/{webform}/json/schema` | `GetSchemaController` | `webform.view` |
| `GET /webform/{webform}/json/settings` | `GetSettingsController` | `webform.view` |
| `POST /webform/{webform}/json/upload` | `UploadFileController` | `webform.submission_create` |
| `POST /webform/{webform}/json/submission` | `CreateSubmissionController` | `webform.submission_create` |
| `PATCH /webform/{webform}/json/submission/{submission}` | `UpdateSubmissionController` | `submission.update` |
| `GET /webform/{webform}/json/submission/{submission}` | `GetSubmissionController` | `submission.view` |

## Schema selection
`?schema=` picks a `WebformJsonSchema` plugin. Built-in: `form_kit` (FormKit), `json_forms` (JsonForms). Response for schema = `{schema: [...], values: {...}}`.

## Creating / updating (`Submitter`)
- Payload may be `application/x-www-form-urlencoded`, `multipart/form-data`, or `application/json`; other content types are rejected.
- `WebformSubmissionForm::isOpen()` is enforced; closed/scheduled forms are refused.
- Data is normalized by the schema plugin, then validated by submitting the real `webform_submission` "api" form — so element validation, conditions, and spam/handler logic (honeypot, CAPTCHA, etc.) run exactly as for a browser submit.
- `?draft=1` saves a draft where drafts are enabled (`checkDraftEnabled`).
- On new submissions the `Referer` is resolved via `url_entity` and stored as the submission's source entity/URI.
- Errors return `{errors: [{message, path}]}`; success returns `{uuid, data, confirmation}`.

## Files
`POST .../json/upload` with `files[{element}][]` returns `{ {element}: [fid,...] }`; those fids are then referenced in the submission create call.

## Extending
Implement a `#[WebformJsonSchema]` plugin (extend `WebformJsonSchemaBase`) to add a schema format; it is discovered by `plugin.manager.webform_headless`.

## Admin UI submodule
`webform_headless_ui` adds `/admin/structure/webform/headless` (`access administration pages`) and a JSON Forms inspector at `/admin/structure/webform/headless/json-forms` (`access json forms ui`).
