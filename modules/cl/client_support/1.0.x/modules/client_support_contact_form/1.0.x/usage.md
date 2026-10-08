The reference support integration for Client Support: it redirects the Support tab to a core Contact Form ("Support Form") that it installs with severity, issue-URL and file-attachment fields.

---

Client Support - Contact Form is the ready-made plugin that gives the parent Client Support module something to point at. Enabling it registers a `SupportIntegration` plugin called "Contact Form Integration" and installs a core Contact form named **Support Form** (machine name `support_form`). Once you select that plugin on the Client Support settings form, clicking the Support toolbar tab redirects the user to `/contact/support_form`. The installed form is a standard core Contact form — core handles rendering, access and emailing the submission to the form's configured recipients — with three extra fields added: a required **Severity** select (Low / Medium / High / Critical), a required, repeatable **Issue URLs** link field, and an optional, repeatable **Issue attachments** file field (broad set of document/image/media extensions, stored in the public files directory). The form ships with a placeholder recipient of `webmaster@example.com`, so set a real recipient under Structure → Contact forms before going live. It depends on the core Contact, File, Link and Options modules, which Drupal enables automatically.

---

- Give the Client Support module a working support destination out of the box.
- Redirect the Support tab to a core Contact Form named "Support Form".
- Install that contact form automatically when the submodule is enabled.
- Let submitters set an issue severity (Low / Medium / High / Critical).
- Collect one or more relevant issue URLs on the form.
- Let submitters attach one or more files (screenshots, screen recordings, documents).
- Reuse core Contact for form rendering, access control and email delivery.
- Email each submission to the recipient address configured on the Support Form.
- Serve as the reference implementation for writing your own SupportIntegration plugin.
- Depend on core Contact, File, Link and Options (enabled automatically).
- Work on Drupal 10 and 11.
