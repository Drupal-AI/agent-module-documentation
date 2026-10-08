<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Forms Feedback Form (localgov_forms_feedback_form) — agent index

A minimal LocalGov Drupal submodule that ships one pre-built Webform — a "Was this page helpful?" Yes/No
feedback form with a conditional follow-up textarea — plus a small CSS library. No PHP logic beyond a
form-alter that attaches the CSS. Package `LocalGov Drupal`. Core `^10 || ^11`. GPL-2.0-or-later.
Part of `localgov_forms`.

- **The shipped Webform, the CSS, the install message, and how to deploy/read it** →
  [config/feedback-form.md](config/feedback-form.md)

## Dependencies

- `webform:webform` and `webform:webform_ui`.

## What it actually is (from source)

- **No** routes, permissions, services, entities, plugins, Drush, or `config/schema`.
- `config/install/webform.webform.localgov_forms_feedback_form.yml` — Webform config entity, id
  `localgov_forms_feedback_form`, title "Feedback Form". Elements: `was_this_page_helpful` (radios
  Yes/No), `response_for_yes` + `response_for_no` (textareas, shown via `#states` on the radio value).
  `access.create` = anonymous + authenticated; `form_disable_remote_addr: true`; inline confirmation
  "Thanks for your feedback"; results stored in the site DB (default Webform storage).
- `localgov_forms_feedback_form.module` — one hook,
  `hook_form_webform_submission_localgov_forms_feedback_form_add_form_alter()`, attaches library
  `localgov_forms_feedback_form/localgov_forms_feedback_form`.
- `localgov_forms_feedback_form.libraries.yml` — CSS-only library (`css/localgov-forms-feedback-form.css`).
- `localgov_forms_feedback_form.install` — `hook_install()` adds a status message: submissions are stored
  in the DB; check with your data protection officer or change where the data is stored.

## Operating

- Deploy by placing a **Webform block** for `localgov_forms_feedback_form` (`Structure > Blocks`).
- Read submissions at `Structure > Webforms → LocalGov Forms Feedback Form → Results` (uses core Webform
  submission permissions, e.g. `view any webform submission` / `administer webform submission`).
