# Configuration

Contact Emails does not have a single "settings" screen that governs its
behaviour. Instead, each email you want a form to send is its own small record
(a `contact_email` entity) that you add to a contact form. One tiny global
setting — a UTF-8 charset toggle — lives on a separate settings page.

You need the **Manage contact form emails** permission (`manage contact form
emails`) to add and edit emails; the global settings page additionally needs the
core **Administer contact forms** permission.

## Where to manage emails

There are two ways in, and they edit the same emails:

- **The central list** — **Structure → Contact forms → Emails**
  (`/admin/structure/contact/emails`) shows every email across every form.
- **Per form** — on a contact form's row (under *Structure → Contact forms*) use
  the **Emails** operation, or open the form and use its **Emails** tab, to see
  and edit just that form's emails.

From either list, click **Add email** to create one, or use the edit / delete
operations on an existing email.

## Add or edit an email — field by field

Each email has these fields:

- **Subject** — the email's subject line. It is token-aware: you can drop in
  `[contact_message:subject]`, the submitter's name, and other
  `[contact_message:*]` or global tokens, which are filled in when the mail is
  sent.
- **Message** — the body. It uses a formatted (rich-text) editor, so you can send
  HTML or plain text depending on the text format you choose. Tokens work here
  too.
- **Append the entire message** — a checkbox that adds the full rendered
  submission underneath your custom body, so recipients see everything the
  visitor entered even if your body is a short intro.
- **Enabled** — a checkbox. Untick it to switch an email off temporarily without
  deleting it (useful for seasonal or paused notifications).

### Who receives it — the recipient type

The **recipient type** decides where the email is sent:

- **Manual** — you type one or more literal addresses (separated by commas,
  semicolons or new lines) into a **Recipients** box. Use this for "always send
  to sales@ and support@".
- **Submitter** — sends to the email address the person entered in the form, so
  the email is effectively an auto-reply / confirmation to them.
- **Field** — reads the destination address from a named field on the
  submission, e.g. a "Department" picker that stores an address.
- **Reference** — follows a reference to an email field on a related entity
  (for example, the referenced staff member on a "contact this team member"
  form).
- **Context** — sends to the owner / author of the entity in the current page
  context.
- **Default** — falls back to the site's default email address (from *Basic site
  settings*), handy for a catch-all.

### Where replies go — the reply-to type

The **reply-to type** works the same way and controls the email's Reply-To
header, so replies land in the right inbox:

- **Default** — the site email address.
- **Submitter** — the person who filled in the form (so you can just hit Reply to
  answer them).
- **Field** / **Reference** / **Context** — pull the reply address from a message
  field, a referenced entity's email field, or the context entity's author,
  respectively.
- **Manual** — a literal address you type in.

Because each email is independent, you can mix these freely — for example one
email to your team (manual recipients, reply-to = submitter) plus a second
"submitter" email that auto-replies to the visitor.

## What happens on the contact form itself

As soon as a form has at least one email here, Contact Emails takes over sending
for that form. On the form's own edit page the core **Recipients** and
**Auto-reply** fields are hidden and replaced with a note that "Emails for this
form are managed here", and core's own contact mail is suppressed so nothing is
sent twice.

## The one global setting

**Structure → Contact forms → Emails → Settings**
(`/admin/structure/contact/emails/settings`) has a single option that controls
the UTF-8 charset header:

- **Allow UTF-8 charset** — when ticked, HTML mails are sent with a
  `text/html; charset=UTF-8` header so non-ASCII characters in recipients and
  subjects render correctly. Leave it off unless you see garbled accented or
  non-Latin characters.

You can also read or set it from the command line:

```bash
drush cget contact_emails.settings allow_charset_utf_8
drush cset contact_emails.settings allow_charset_utf_8 true -y
```

## Translating emails

The `contact_email` entity is translatable, so on a multilingual site you can
give each email a per-language subject and body through the usual translation
workflow.
