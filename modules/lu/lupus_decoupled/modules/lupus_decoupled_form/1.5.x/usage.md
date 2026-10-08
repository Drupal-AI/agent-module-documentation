<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Form gives modules an API for rendering Drupal forms as custom elements, so a decoupled front end can present and submit them.

---

Forms are the hardest thing to decouple, and the reason is validation. A Drupal form is not markup — it is an element tree with server-side validation, constraints, `#states`, AJAX callbacks and CSRF protection. A front end that rebuilds the markup and posts JSON reimplements all of that, usually incompletely, and the gaps are where bad data and security problems get in.

This submodule takes the other route: Drupal renders the form as custom elements, including its validation metadata, and the front end hydrates it into components. Submission goes back through Drupal's form API, so validation, constraints and CSRF handling are the ones Drupal already ships.

It is the base other form-related submodules build on — `lupus_decoupled_user_form`, `lupus_decoupled_contact` and `lupus_decoupled_webform` all rest on this. If you are exposing a custom module's form to the front end, this is the API to use rather than inventing an endpoint.

---

- Render a Drupal form in a decoupled front end.
- Keep server-side validation authoritative.
- Preserve CSRF protection on a decoupled form.
- Expose a custom module's form to the front end.
- Submit a form back through Drupal's form API.
- Reuse Drupal's constraint system.
- Avoid reimplementing validation in the front end.
- Style form elements in the front end.
- Support conditional fields in a decoupled form.
- Handle form errors returned by Drupal.
- Underpin user, contact and webform integrations.
- Add a new form type to a decoupled build.
- Debug a submission rejected by validation.
- Keep form logic in one place.
- Plan form handling for a headless site.