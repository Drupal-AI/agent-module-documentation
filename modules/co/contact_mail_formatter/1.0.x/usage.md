<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Mail Formatter replaces the plain-text email sent by core contact forms with a configurable HTML template that supports Drupal tokens, including contact-message field tokens.
---
The module alters the core contact form add/edit UI (`contact_form_add_form` / `contact_form_edit_form`) to add a "Mail Formatter" section where an administrator enables HTML mail per contact form, picks one of the bundled templates (Template 1–3 or Custom HTML), and edits the HTML in a CKEditor `full_html` text-format field with a token browser (`contact_message` and global tokens). Selections are saved as third-party settings on the contact form config entity. At send time, `hook_mail_alter()` intercepts the `contact_page_mail` message, replaces the tokens using the actual contact message entity via `\Drupal::token()->replace()`, sets the `Content-Type` header to `text/html`, and wraps the body in `<html><body>` when needed. A `token_info_alter` hook adds convenient `site:logo` / `site:logo-url` tokens.

Operationally, configuration is limited to users who can administer contact forms (the core `contact_form_edit_form` gate), so there is no anonymous configuration surface. The HTML template itself is authored by a trusted admin through the `full_html` editor. User-submitted contact fields enter the email only through token replacement: the module calls `token->replace()` without `['sanitize' => FALSE]`, so token values are sanitized by the token system's default (HTML-escaped) behavior — mitigating HTML/script injection from submitter input into the outgoing mail. No routes, permissions, or services are added.
---
- Enable the module (requires core Contact and Token).
- Edit a contact form and open the "Mail Formatter" section.
- Enable HTML mail formatting for that contact form.
- Choose Template 1, 2, 3, or Custom HTML.
- Edit the HTML body in the CKEditor full_html field.
- Insert contact-message and global tokens via the token browser.
- Use `site:logo` / `site:logo-url` tokens in the template.
- Send branded HTML notification emails from contact submissions.
- Preview the template live in the form (JS-driven).
- Include submitter name/email/message via `contact_message` tokens.
- Wrap custom HTML automatically in document tags when needed.
- Keep per-contact-form templates via third-party settings.
- Use inline CSS and absolute image URLs for email compatibility.
- Fall back to plain text when formatting is disabled for a form.
- Author templates as a trusted admin (full_html editor).