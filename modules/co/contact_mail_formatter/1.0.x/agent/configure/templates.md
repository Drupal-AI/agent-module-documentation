<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring HTML contact mail

**Where:** edit any contact form (`/admin/structure/contact/manage/<form>`) → **Mail Formatter** section (added by a form alter). Requires core contact-form admin access.

## Steps
1. Tick **Enable Mail Formatter**.
2. Select a **template**: `Template 1 - Contact Details`, `Template 2`, `Template 3`, or **Custom HTML**.
3. Edit the **Mail HTML** in the CKEditor `full_html` field. Use inline CSS and absolute image URLs for email-client compatibility.
4. Insert tokens from the browser: `contact_message` tokens (submitter name/email/subject/message), global tokens, and the module's `site:logo` / `site:logo-url`.
5. Save — values persist as third-party settings on the contact form entity.

## At send time (`hook_mail_alter`)
- Only the `contact_page_mail` message is altered, and only when the form has the formatter enabled with saved HTML.
- Tokens are replaced with the live contact message via `\Drupal::token()->replace($body, ['contact_message' => $message])`.
- `Content-Type` is set to `text/html`; the body is wrapped in `<html><body>` if it isn't already a full document.

## Security
Token replacement uses the default sanitizing behavior (no `['sanitize' => FALSE]`), so user-submitted field values are HTML-escaped when injected into the mail. The HTML template is authored by a trusted admin through the `full_html` editor.
