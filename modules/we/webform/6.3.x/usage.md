Webform is a comprehensive form builder for Drupal that lets site builders create forms, surveys, and questionnaires from a large library of elements and then collect, review, and route the submissions — all without writing code.

---

Webform models each form as a `webform` config entity and each response as a `webform_submission` content entity, so forms are exportable/deployable as configuration while their data lives in the database. Forms are assembled from a rich element library (text, select, checkboxes, dates, file uploads, composites, likert, address, signature, computed values, wizard pages, and more) that extends Drupal's Form API render elements, edited either through a YAML source editor or the drag-and-drop UI (webform_ui submodule). Behavior is driven by per-element **conditional logic** (`#states`), validation, multistep wizards, and reusable **options** lists. What happens on submit is handled by pluggable **handlers** — the built-in Email and Remote Post handlers send notifications/confirmations and POST data to external APIs, while custom handlers can invoke any code. Submissions can be reviewed, edited, and **exported** to CSV/TSV/JSON/YAML (plus PDF/DOCX via submodules), and access is governed by a fine-grained permission and access-rules system. Developers extend it through five plugin types (WebformElement, WebformHandler, WebformExporter, WebformVariant, WebformSourceEntity), a broad set of alter hooks, and a Drush command set for generating, exporting, purging, and repairing forms.

---

- Build a site-wide contact form with email notification and confirmation messages.
- Create multi-page wizard surveys with progress bars and page navigation.
- Collect job applications with file/resume uploads and email the HR team.
- Send an autoresponder confirmation email to the person who submitted a form.
- POST submission data to an external CRM or marketing API via the Remote Post handler.
- Add conditional logic so fields show/hide based on earlier answers.
- Run event registrations with per-option submission limits (webform_options_limit).
- Embed a webform inside page content as a node (webform_node).
- Reuse a saved form as a template to spin up new webforms quickly (webform_templates).
- Export all submissions to CSV/Excel for analysis.
- Generate downloadable/emailed PDF copies of submissions (webform_entity_print).
- Build likert-scale and rating questionnaires for feedback surveys.
- Require CAPTCHA or honeypot protection on public-facing forms.
- Save partial progress and let users resume a long form later (draft support).
- Restrict who can view/edit submissions with granular per-form permissions.
- Create composite elements (e.g. name + address groups) reused across forms.
- Schedule reminder or follow-up emails after submission (webform_scheduled_email).
- Add computed/hidden fields that calculate values from other inputs.
- Log every submission event for auditing (webform_submission_log).
- Share/embed a form on external sites via an iframe or script (webform_share).
- Provide a "quiz" style form with answer validation.
- Prefill form fields from URL query parameters or tokens.
- Localize/translate form labels and messages on multilingual sites.
- Limit total submissions or open/close a form on a schedule.
- Build image-choice pickers where users select from thumbnails (webform_image_select).
- Grant editors group-based access to specific webform nodes (webform_access).
- Import and export submissions between environments (webform_submission_export_import).
- Present long forms as fast client-side stepped cards (webform_cards).
- Send data to a Slack/webhook endpoint on submission.
- Generate test submissions with Drush for load/UX testing.
