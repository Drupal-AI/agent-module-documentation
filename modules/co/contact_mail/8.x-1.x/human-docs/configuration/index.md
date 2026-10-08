# Configuration

Contact Mail adds a single settings form that controls common recipients and how
core Contact-form emails are formatted. The settings apply to the **site-wide
contact form** mail (and the sender's "send yourself a copy" mail).

## Open the settings form

1. Log in as a user with the **Administer contact forms** permission (an
   administrator by default). This is the same permission that guards the form's
   route.
2. Go to **Administration › Configuration › System › Contact Mail Settings**, or
   visit `/admin/config/system/contact-mail` directly.

> Don't use the **Configure** link on the Extend page — it points at an old route
> (`synmail.config`) that no longer exists and is broken. The
> Configuration › System menu link works.

## The settings

The form (under a "Contact Form" section) has four fields:

- **Contact form Recipients** (`emails`) — one email address per line. Each valid
  address is **added** to the recipient list of every contact-form email the site
  sends, on top of the form's own configured recipients. Use this to send a copy of
  all contact submissions to a shared inbox without editing each form. (Addresses
  are accepted only if they contain both an `@` and a `.`.)
- **Rewrite submission template** (`tpl`, on by default) — when enabled, the module
  re-renders the submitted fields into a tidy, labelled block and prepends the
  "extra information" header (below) to the email body.
- **Send html instead txt** (`html`, on by default) — sends the email with a
  `text/html` Content-Type instead of plain text, so the formatted output and any
  HTML in the header render as HTML in the recipient's mail client.
- **Mail extra information** (`header`) — an HTML block added to the top of the
  email body (only when "Rewrite submission template" is on). The default is a
  short "Do not reply / find the customer's email in the message" notice. Edit it
  to suit your team.

## A note on submitter data

Contact-form emails carry the submitter's message and, frequently, their email
address. Because the **Recipients** field routes a copy of *every* contact
submission to the addresses you list, double-check that list so submissions only
reach people who should see them.

## Save

Click **Save configuration**. Changes apply to contact-form mail sent from then on
— submit a test contact form to confirm the recipients and formatting behave as you
expect.
