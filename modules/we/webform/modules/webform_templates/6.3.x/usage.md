Webform Templates ships a library of ready-made starter webforms (contact, feedback, registration, job application, and more) that editors can browse, preview, and copy as the basis for a new form.

---

Rather than building common forms from scratch, Webform Templates provides prebuilt webforms flagged as templates and lists them at `/admin/structure/webform/templates`. Each template is a normal `webform.webform.template_*` config entity (the module installs eleven: contact, feedback, subscribe, registration, job application, job seeker profile, employee evaluation, session evaluation, medical appointment, issue, and user profile). Editors preview a template at `/webform/{webform}/preview`, then duplicate it into a new, editable webform — the copy is an independent form, not linked back to the template. A filter form and autocomplete help find a template by name/category, and an "administer webform templates" permission gates managing which forms are marked as templates. It is a fast on-ramp for site builders who want a sensible starting point, and a pattern library teams can extend with their own templates.

---

- Start a new contact form from the built-in contact template.
- Spin up a feedback form without building it from scratch.
- Create a newsletter subscribe form from a template.
- Launch an event/session registration form quickly.
- Use the job application template for a careers page.
- Provide a job-seeker profile form from a template.
- Start an employee evaluation form from boilerplate.
- Create a session evaluation/survey from a template.
- Build a medical appointment request form fast.
- Use the issue-reporting template for support intake.
- Create a user profile form from a template.
- Browse all available templates in one admin list.
- Preview a template before adopting it.
- Duplicate a template into an independent editable webform.
- Filter/search templates by name or category.
- Give teams a consistent starting point for common forms.
- Establish an internal pattern library of approved form layouts.
- Speed up prototyping of new forms during workshops.
- Mark your own custom webforms as reusable templates.
- Gate template administration behind a dedicated permission.
