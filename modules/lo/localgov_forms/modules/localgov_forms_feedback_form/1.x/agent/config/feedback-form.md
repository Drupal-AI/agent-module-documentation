<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The feedback form: config, CSS, install, and how to run it

This submodule is essentially one Webform plus styling. There is no custom controller, service, plugin,
route, permission, or config schema.

## Install / enable

- `drush en localgov_forms_feedback_form`. Requires `webform` and `webform_ui`.
- On install, `hook_install()` (`localgov_forms_feedback_form.install`) shows a status message via
  `\Drupal::messenger()->addStatus(...)`: the form stores submissions in the site database — confirm this is
  acceptable with your data protection officer, or change the form settings to store data elsewhere.

## The Webform (`config/install/webform.webform.localgov_forms_feedback_form.yml`)

- Id `localgov_forms_feedback_form`, title "Feedback Form", status `open`.
- Elements:
  - `was_this_page_helpful` — `radios`, options `Yes` / `No`, title "Was this page helpful?".
  - `response_for_yes` — `textarea` "Great. Want to tell us what you liked about it?", shown only when
    `was_this_page_helpful == Yes` (Webform `#states.visible`).
  - `response_for_no` — `textarea` "Sorry to hear that. How can we improve it?", shown only when
    `was_this_page_helpful == No`.
- Key settings: `form_disable_remote_addr: true` (does **not** store submitter IP); `css: localgov-forms-feedback-form`
  and `form_attributes.class: [localgov-forms-feedback-form]`; `confirmation_type: inline` with title
  "Thanks for your feedback"; `form_title: source_entity_webform`; `submission_user_columns: [serial, created]`.
- Access: `access.create.roles: [anonymous, authenticated]` — both anonymous and logged-in users may submit.
  All other operations (view/update/delete/purge/administer) are left to core Webform's permission model
  (no roles granted in this config), so viewing results requires a Webform submission permission such as
  `view any webform submission` or `administer webform submission`.
- Results are stored in the default Webform submission storage (the site database); `results_disabled: false`.

## CSS library and its attachment

- `localgov_forms_feedback_form.libraries.yml` defines one library
  `localgov_forms_feedback_form` → `css/localgov-forms-feedback-form.css` (theme CSS, no JS).
- `localgov_forms_feedback_form.module` implements
  `hook_form_webform_submission_localgov_forms_feedback_form_add_form_alter()` and appends the library to
  `$form['#attached']['library']`, so the CSS loads on the form's add page.

## Deploying and reading feedback

- Surface the form by adding a **Webform block** for `localgov_forms_feedback_form` in
  `Admin > Structure > Blocks` (per the README), placed on the pages/regions you want.
- Review responses at `Admin > Structure > Webforms → LocalGov Forms Feedback Form → Results`.
- To store data somewhere other than the site DB (CRM, offsite backup, separate database), edit the form's
  submission settings / add a suitable handler — the module ships DB storage only as the default.
