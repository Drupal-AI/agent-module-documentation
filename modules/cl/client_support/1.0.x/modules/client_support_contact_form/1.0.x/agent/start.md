<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client Support - Contact Form (client_support_contact_form) — agent index

Submodule of **`client_support`**. The reference **SupportIntegration** plugin: it points the
Client Support "Support" toolbar tab at a **core Contact Form** and installs that form (bundle
`support_form`) with a few extra fields. Package `Support`. Core `^10 || ^11`. Version 1.0.1.

Parent module: [../../../../agent/start.md](../../../../agent/start.md).

## Dependencies (`.info.yml`)

`drupal:client_support`, `drupal:contact`, `drupal:file`, `drupal:link`, `drupal:options`.

## What it provides (from source)

- **Plugin** `Plugin/SupportIntegration/ContactFormIntegration` — id `contact_form`, title
  "Contact Form Integration". `redirect()` returns:
  ```php
  new TrustedRedirectResponse(
    Url::fromRoute('entity.contact_form.canonical', ['contact_form' => 'support_form'])
      ->toString(TRUE)->getGeneratedUrl()
  );
  ```
  A fixed internal route — no user input in the URL.
- **Installed config** (`config/install/`, applied when the submodule is enabled):
  - `contact.form.support_form` — a core Contact form "Support Form". `recipients:
    [webmaster@example.com]` (placeholder — admins must change it), `reply: ''`,
    `message: 'Thank you for sending feedback!'`, no redirect.
  - Three fields on `contact_message` bundle `support_form`:
    - **`client_support_severity`** — `list_integer` (options 0 Low / 1 Medium / 2 High /
      3 Critical), **required**, cardinality 1, `options_select` widget.
    - **`client_support_issue_urls`** — `link` field, **required**, external links
      (`link_type: 1`), unlimited cardinality (`-1`), no link title.
    - **`client_support_attachments`** — `file` field, optional, unlimited cardinality,
      **`uri_scheme: public`**, `max_filesize: 256MB`, `file_directory: '[date:custom:Y]-[date:custom:m]'`,
      extensions `zip rar csv xml bmp gif jpg jpeg png tif tiff avi mp4 mov txt doc docx pdf odt`
      (no executable/php/svg types), `description_field: true`.
  - Default `entity_form_display` and `entity_view_display` for the bundle.
- **No PHP services, routes, permissions, hooks, install file, or config schema of its own** — it
  relies on core Contact for form rendering, access and email delivery.

## Behaviour notes

- Access to the form is core Contact's: reaching `/contact/support_form` needs core's *"Use the
  site-wide contact form"* permission (independent of `access client support`, which only governs
  the toolbar tab / `/client-support` redirect).
- Email is sent by core Contact's mail handling; this submodule adds no mailer code.
- The severity/issue-URL/attachment fields render on the message and in the admin view display via
  standard core formatters (`list_default`, `link`, `file_default`, `string`).
