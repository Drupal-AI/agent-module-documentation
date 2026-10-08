<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Webform exposes Webform's form definitions and its submission pipeline through GraphQL: a `webformById` query returns a built form and its elements, and a `submitWebform` mutation creates a real, server-validated Webform submission — so a decoupled front end renders a Drupal-managed form and posts to it.

---

Forms are the hardest thing to decouple well. A JavaScript front end fetches content easily, then has to reproduce the form — every field, its validation, its conditional logic, its options and its error messages — all of which live in Webform's configuration and change whenever an editor edits the form. Reimplementing that means the two drift, and drift shows up as a form that accepts what the server rejects. This module inverts it: the front end queries `webformById(id) { form { elements { ... } } }` and renders from the answer, where each element is a concrete GraphQL type (`WebformElementTextfield`, `WebformElementSelect`, `WebformElementManagedFile`, ...) exposing its metadata, validation and options; the `form` is a *built instance* (`WebformForm`) that depends on the source entity and the current user's access, and its `unavailable` field reports — with a machine-readable `reason` (`CLOSED`, `OPENING`, `SOURCE_ENTITY_REQUIRED`, ...) — when the form cannot be filled in. Submitting goes through `submitWebform(id, elements, files, requestValues, sourceEntityType, sourceEntityId)`, which runs Webform's programmatic **`api` form pipeline**: it checks the form is open and that the caller has `submission_create` access, runs every element's server-side validators, and returns a `WebformSubmissionResult { errors, validationErrors { element, messages }, submission { id, token, confirmation } }`. Three specifics matter. **Server-side validation is the real validation** — the mutation re-runs Webform's Form API validators, so a decoupled client's own checks are only a convenience. **CAPTCHA works over the API on purpose**: the `graphql_webform_captcha` submodule exposes each provider's public render settings (reCAPTCHA v2/v3, Turnstile — never the secret keys), the client renders the widget, and the solved token is posted back in the `requestValues` argument, which the module places on a synthetic POST request so the CAPTCHA element validates exactly as it would on an HTML form. **File uploads use the GraphQL multipart request spec** (a `files` argument plus a `map`), and multi-value/composite element keys use `container[0][child]` bracket syntax — check both against the site's real forms, not a simple contact form.

---

- Render a Drupal webform in a React front end from `webformById`.
- Post submissions from a decoupled site with `submitWebform`.
- Read a form's elements, labels, options and validation over GraphQL.
- Avoid reimplementing Webform's validation on the client.
- Let editors change a decoupled form without a front-end deploy.
- Return per-field validation errors to a headless client.
- Show a confirmation message/redirect after a submission.
- Detect a closed or not-yet-open form via `WebformForm.unavailable`.
- Branch on `unavailable.reason` (CLOSED / OPENING / SOURCE_ENTITY_REQUIRED).
- Add reCAPTCHA or Turnstile to a decoupled form via the captcha submodule.
- Send a solved CAPTCHA token back through `requestValues`.
- Upload files from a headless form using the multipart request spec.
- Submit composite / multi-value elements with bracketed keys.
- Attach a submission to a source entity (node, term, ...).
- Prepopulate element defaults from a query string via the `prepopulate` argument.
- Resolve entity-autocomplete matches with `webformEntityAutocomplete`.
- Support a mobile app's forms from one Drupal source of truth.
- Build a Next.js / Nuxt form from a Webform definition.
- Keep conditional `#states` logic in Drupal and expose it to the client.
- Support a decoupled survey or registration form.
- Expose element help, descriptions and placeholders to the front end.
- Fetch a submission's confirmation later with `webformConfirmation(submissionId, token)`.
- Render a signature, Likert, or address element in a decoupled UI.
- Keep editorial control of forms while shipping a JS front end.
