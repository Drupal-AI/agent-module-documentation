<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Webform (graphql_webform) — agent index

Exposes **Webform** form definitions and its submission pipeline over **GraphQL** (the
`drupal/graphql` 5.x schema). Requires `webform 6.x` and `graphql 5.x`; declares `php: 8.3`;
core `^10.3 || ^11`. Version **3.0.0-beta1** (beta). Ships submodule
`graphql_webform_captcha`. No permissions, no routes, no hooks, no Drupal config schema of its
own — everything is GraphQL schema extensions + data producers registered against a GraphQL
**server** you configure with the `graphql` module (the server's config governs endpoint access;
per-field access is this module's job).

## What it adds to the schema

- **`Query.webformById(id, sourceEntityType, sourceEntityId, prepopulate)` → `Webform`**
  (`id`, `label`, `settings`, `form`). Access-checked: returns `null` unless the current user
  has `view` access to the webform config entity.
- **`Webform.form(sourceEntityType, sourceEntityId)` → `WebformForm`** — a *built form
  instance* (context-dependent). Carries `elements` (a `[WebformElement]` union with one
  concrete type per Webform element plugin), `title`, `sourceEntity*`, and `unavailable`
  (`message`, `type`, machine-readable `reason`).
- **`Mutation.submitWebform(id, elements, files, requestValues, sourceEntityId, sourceEntityType)`
  → `WebformSubmissionResult`** (`errors`, `validationErrors`, `submission`). Creates a real
  submission through Webform's programmatic `api` form pipeline.
- **`Query.webformConfirmation(submissionId, token, webformId)` → `WebformSubmissionConfirmation`**.
  Loading a submission requires its secret `token`.
- **`Query.webformEntityAutocomplete(webformId, elementKey, input)` → `[WebformEntityReference!]!`**.

## Read this next

- **[schema/queries.md](schema/queries.md)** — the query side: `webformById` → `Webform` →
  `WebformForm` → `elements`, the per-element types, `settings`, `unavailable`, source entities,
  `prepopulate`, `webformEntityAutocomplete`, `webformConfirmation`.
- **[mutations/submit.md](mutations/submit.md)** — the `submitWebform` mutation: element/value
  shape, unflattening of bracketed composite keys, file uploads (multipart spec), source
  entities, the `api` pipeline and what access/validation it enforces, `requestValues`, and the
  result shape.
- **[captcha/submodule.md](captcha/submodule.md)** — `graphql_webform_captcha`: how CAPTCHA is
  rendered client-side and validated server-side over the API.

## Key facts for an agent

1. **`form` is a built instance, not the config entity (3.x breaking change).** `elements`,
   `title`, `sourceEntity*` moved from `Webform` onto the new `WebformForm` type. Query them under
   `webformById(id: "...") { form { elements } }`.
2. **Server-side validation is the only validation.** `submitWebform` re-runs Webform's Form API
   validators (`#required`, `#pattern`, `#maxlength`, `#element_validate`, date bounds, file
   constraints). A client's own checks are advisory.
3. **CAPTCHA is enforced over the API, honeypot/time checks are not.** The captcha submodule +
   `requestValues` make the CAPTCHA element validate server-side; hidden-field-based protections
   (honeypot, time trap) do not survive a client that renders its own markup.
4. **Submissions are not readable back as data.** `WebformSubmission` exposes only
   `id`/`uuid`/`token`/`tokenUrl`/`webform`/`sourceEntity*`/`confirmation` — there is no field
   returning stored element values, so the schema cannot dump other users' submission data.
