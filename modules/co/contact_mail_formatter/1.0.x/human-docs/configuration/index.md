# Configuration

This module has no central settings page. Instead it adds a **Mail Formatter**
section to each contact form's add/edit screen, so you enable and design the HTML
email per contact form. Only users who can administer contact forms can reach it.

## Open a contact form's Mail Formatter section

1. Log in as a user who can administer contact forms (an administrator by default).
2. Go to **Structure → Contact forms** (`/admin/structure/contact`) and edit the
   form you want (the direct path is `/admin/structure/contact/manage/<form>`).
3. Find the **Mail Formatter** section that the module adds to the form.

## Enable and design the email

1. **Enable Mail Formatter** — tick this to turn on HTML formatting for this
   contact form. (Leave it off and the form keeps sending core's plain-text email.)
2. **Choose a template** — pick one of the bundled templates:
   - **Template 1 – Contact Details**
   - **Template 2**
   - **Template 3**
   - **Custom HTML** — start from your own markup.
3. **Edit the Mail HTML** — the body is edited in a CKEditor (`full_html`) field.
   For reliable rendering across email clients, use **inline CSS** and **absolute
   image URLs**.
4. **Insert tokens** — use the token browser to drop in:
   - **`contact_message` tokens** — the submitter's name, email, subject, and
     message.
   - **Global tokens** — site and other standard tokens.
   - **`site:logo` / `site:logo-url`** — convenience tokens this module adds for
     your site logo.
5. Some versions offer a live **preview** of the template in the form as you edit.
6. **Save** — your choices are stored on the contact form itself (as third-party
   settings), so each form keeps its own template.

## How it behaves when mail is sent

When a form with the formatter enabled sends its notification, the module fills the
tokens with the real submission's values, sets the email's `Content-Type` to
`text/html`, and wraps the body in `<html><body>` if it isn't already a full
document. Forms where you left the formatter disabled continue to send core's plain
text.

## A note on safety

Token replacement runs with the token system's default **sanitizing** behavior, so
values a visitor typed into the form are HTML-escaped when they're injected into the
email — submitter input can't inject markup or scripts into the outgoing mail. The
template markup itself is authored by a trusted admin through the `full_html`
editor, so keep the ability to administer contact forms limited to trusted roles.
