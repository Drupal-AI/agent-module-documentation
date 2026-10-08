<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mutation side: `submitWebform`

```graphql
mutation ($id: String!, $elements: [WebformSubmissionElement]!) {
  submitWebform(id: $id, elements: $elements) {
    errors
    validationErrors { element messages }
    submission {
      id uuid token tokenUrl
      webform { id }
      confirmation { type title message redirectUrl }
    }
  }
}
```

## Arguments

- **`id: String!`** — the webform machine name.
- **`elements: [WebformSubmissionElement]`** — array of `{ element, value }`. `element` is the
  element key; `value` is a `WebformSubmissionValue` scalar (anything the Form API accepts —
  string, number, or list for multi-value). Composite / multi-value keys use bracket syntax:
  `custom_composite[first_name]` for a single-value container, `custom_composite[0][first_name]`
  when the container is multi-value. The producer unflattens these into the nested Form API shape.
- **`files: [WebformSubmissionFile]`** — `{ element, file }` for managed-file elements; the file
  is uploaded per the [GraphQL multipart request spec](https://github.com/jaydenseric/graphql-multipart-request-spec)
  (an `operations` + `map` + file parts request). Uploads are validated against the element's
  configured extensions / max size / uri scheme via the `graphql` module's file-upload service.
- **`requestValues: [WebformRequestValue]`** — `{ name, value }` pairs placed on the synthetic
  POST request (not stored as submission data). This is how a solved CAPTCHA token is delivered:
  the CAPTCHA element reads its token field off the request exactly as it would on an HTML form.
  See `captcha/submodule.md`.
- **`sourceEntityType` / `sourceEntityId`** — attach the submission to a source entity.

## Mechanism (`WebformSubmit` data producer, `webform_submit`)

The mutation does **not** just write a row — it runs Webform's real programmatic form pipeline:

1. Load the webform; error `Webform <id> does not exist.` if missing.
2. **Open check:** `if (!$webform->isOpen())` → returns the configured/default form-closed message
   as an `errors` entry. (Open/close and scheduling only — see the security note about *limits*.)
3. **Access check:** `if (!$webform->access('submission_create'))` → returns the rendered
   access-denied markup as an `errors` entry.
4. Unflatten bracketed keys, handle file uploads, normalize nested `_other` values.
5. Build a synthetic POST `Request` (via `WebformControlledRequestTrait`) carrying `requestValues`
   and a parameter-free synthetic route named `graphql_webform.form_build` — this keeps the CAPTCHA
   element **out of admin auto-solve mode** and gives Webform an active theme, so element
   validators behave as on a real HTML POST.
6. Create a `webform_submission` entity and run `FormBuilder::submitForm()` against the Webform
   `api` form object. **Every element validator fires** (`#required`, `#pattern`, `#maxlength`,
   date format/min/max/day-of-week, `#element_validate`, CAPTCHA), so validation errors come from
   Webform itself, not a reimplementation. The form is validated exactly once (so a single-use
   CAPTCHA token is not consumed twice).
7. On success, `$webformSubmission->save()` and return it; on failure, map Form API errors to
   `validationErrors` (keyed by the top-level element key clients sent).

## Result: `WebformSubmissionResult`

- **`errors: [String]`** — general/form-level errors (form closed, access denied, a file uploaded
  to a non-file element).
- **`validationErrors: [{ element, messages }]`** — per-element validation failures.
- **`submission: WebformSubmission`** — `id`, `uuid`, `token` (the per-submission secret),
  `tokenUrl`, `webform`, `sourceEntity*`, and `confirmation`. **There is no field exposing the
  stored element values**, so a submission cannot be read back as data through the schema.

## Gotchas

- Multi-value and composite element keys must match the element's `multipleValues` shape from the
  query side — include the delta (`[0]`, `[1]`) only when the container/element accepts multiple
  values.
- reCAPTCHA v3 is score-based: configure actions with no fallback challenge for decoupled forms, or
  a failed score becomes an interactive challenge the client cannot render (see the captcha doc).
- The `email_confirm` element expects the plain email string (its documented contract); sending the
  structured `{mail_1, mail_2}` shape is not currently wired.
