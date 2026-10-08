# webform_templates — agent start

Ships 11 prebuilt starter webforms (`webform.webform.template_*` config: contact, feedback,
subscribe, registration, job_application, job_seeker_profile, employee_evaluation,
session_evaluation, medical_appointment, issue, user_profile). Depends only on `webform`.
Browse at `/admin/structure/webform/templates`; preview at `/webform/{webform}/preview`;
duplicate to create an independent new form.

Permission `administer webform templates` (in `webform_templates.permissions.yml`, `restrict
access: true`) gates marking/managing which webforms are templates. No config schema, plugins,
or services of its own — templates are plain webform config entities.
