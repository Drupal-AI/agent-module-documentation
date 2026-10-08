<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform REST exposes Drupal Webform over the REST API: it adds REST resource plugins that let an external or decoupled client fetch a webform's elements/fields and submit (or read/patch) webform submissions as JSON/XML.

---

Webform REST is a thin bridge between the **Webform** module and Drupal core **REST**. It registers five `@RestResource` plugins — `webform_rest_elements` (GET a webform's render-array elements), `webform_rest_fields` (GET a flattened field list with default values/tokens resolved), `webform_rest_submit` (POST a new submission), `webform_rest_submission` (GET/PATCH an existing submission by UUID), and `webform_rest_complete_submission` (GET submission data plus its fields). None of these are active on install: like every core REST resource, each must be **enabled** by creating a `rest.resource.*` config entity (a `rest_resource_config`) that declares the allowed methods, serialization formats, and authentication providers — done with the optional **REST UI** (`restui`) module, by importing config, or programmatically. Once enabled, a decoupled front end (React, a mobile app, an integration) can render a Drupal webform remotely and post back answers; the POST resource runs the same validation, handlers, and hooks as a browser submission and returns the new submission UUID (`sid`). The module also provides a tiny settings form (`webform_rest.settings`, permission `access webform rest settings`) whose single `confirmation_settings` flag optionally includes the webform's confirmation type/URL/message in the submit response, and a `webform_rest.submit.return` **event** (`WebformSubmitReturnEvent`) that lets other modules rewrite the response body/HTTP code. Endpoints live under `/webform_rest/…` and honour the format via `?_format=json`. It does **not** ship its own UI to toggle resources — that is core REST's job.

---

- Fetch a webform's elements as a render array for a decoupled/headless front end (`GET /webform_rest/{id}/elements`)
- Fetch a flattened list of a webform's fields with default values resolved (`GET /webform_rest/{id}/fields`)
- Submit a webform from an external app or SPA (`POST /webform_rest/submit`)
- Build a React/Vue/mobile form UI that renders and posts to a Drupal webform
- Save a submission as a draft over REST (send `"draft": true` in the POST body)
- Retrieve an existing submission by its UUID (`GET /webform_rest/{id}/submission/{uuid}`)
- Update/patch an existing submission over REST (`PATCH /webform_rest/{id}/submission/{uuid}`)
- Retrieve submission data together with the webform's fields in one call (`GET .../complete_submission/{uuid}`)
- Integrate a third-party system (CRM, marketing tool) that pushes leads into a Drupal webform
- Collect form submissions from a static site or JAMstack front end
- Accept submissions from an IoT device or server-to-server job via POST
- Enable only the resources you need by creating the matching `rest_resource_config` entities
- Restrict a resource to specific HTTP methods (e.g. POST-only for submit, GET+PATCH for submission)
- Restrict a resource to specific formats (e.g. JSON only) and auth providers (cookie, basic_auth, oauth)
- Return the webform's confirmation type/message/URL in the submit response (`confirmation_settings`)
- Rewrite or wrap the submit response body and HTTP status via the `webform_rest.submit.return` event
- Reuse Webform's validation, handlers, and email on API submissions (same code path as the UI)
- Enforce webform open/close scheduling and submission-access rules on REST submissions
- Expose a contact or signup webform to a mobile app while keeping content in Drupal
- Localise/tokenise field defaults server-side and deliver them to the client (fields resource)
- Drive automated end-to-end tests that submit webforms through the API
- Configure resources through the REST UI module instead of editing YAML by hand
- Gate the settings page behind the `access webform rest settings` permission
- Migrate away from a legacy form-post endpoint by mapping it to `webform_rest_submit`
