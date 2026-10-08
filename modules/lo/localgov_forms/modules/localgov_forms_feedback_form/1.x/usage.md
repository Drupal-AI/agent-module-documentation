Ships a ready-made "Was this page helpful?" Webform (plus a little CSS) so a LocalGov Drupal site can collect quick page feedback via a Webform block.

---

`localgov_forms_feedback_form` is a very small LocalGov Drupal submodule that provides a single pre-built Webform, `localgov_forms_feedback_form`, titled "Feedback Form". The form asks "Was this page helpful?" with Yes/No radios and reveals a conditional follow-up textarea depending on the answer ("what you liked" for Yes, "how can we improve it?" for No). It ships the Webform as install config, a small CSS library (`localgov_forms_feedback_form/localgov_forms_feedback_form`, `css/localgov-forms-feedback-form.css`) that is attached to the form's add page via `hook_form_FORM_ID_alter()`, and an install-time status message reminding operators that submissions are stored in the site database and to check with their data protection officer. The form allows anonymous and authenticated submissions, disables storing the remote IP address (`form_disable_remote_addr: true`) for privacy, and shows an inline "Thanks for your feedback" confirmation. It depends on `webform` and `webform_ui`; it defines no routes, permissions, services, entities, plugins, or Drush commands, and adds no config schema of its own. You surface it by placing a Webform block for this form and read results from the Webform Results UI.

---

- Add a "Was this page helpful?" feedback widget to a LocalGov Drupal site with no custom code.
- Collect Yes/No page-helpfulness ratings from site visitors.
- Capture free-text detail on what worked ("what you liked about it") when a visitor answers Yes.
- Capture improvement suggestions ("how can we improve it?") when a visitor answers No.
- Show the follow-up textarea conditionally based on the Yes/No answer (Webform `#states`).
- Place the feedback form as a Webform block via `Admin > Structure > Blocks` on pages/regions of your choice.
- Gather anonymous visitor feedback (form permits both anonymous and authenticated submissions).
- Store feedback in the site database and review it under `Admin > Structure > Webforms → LocalGov Forms Feedback Form → Results`.
- Collect page feedback without recording the submitter's IP address (`form_disable_remote_addr` on) for lighter data-protection exposure.
- Give visitors an inline "Thank you for that feedback" confirmation after submitting.
- Provide a consistent, themed feedback form via the bundled CSS library.
- Use as a starting template that editors can clone/extend in the Webform UI (hence the `webform_ui` dependency).
- Redirect submissions to an alternative datastore (CRM, offsite backup, separate DB) by editing the form's submission settings, as the install message and README advise.
- Track qualitative content-quality signals across a council website's pages.
- Prompt content teams to review pages that repeatedly receive "No, not helpful" feedback.
- Deploy a lightweight satisfaction-collection form that matches LocalGov Drupal conventions.
- Serve as an example of shipping a Webform via `config/install` and attaching a CSS library through a form-alter hook.
