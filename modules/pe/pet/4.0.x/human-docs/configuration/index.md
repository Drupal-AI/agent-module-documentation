# Configuration

PET's configuration is spread across three things: the **permissions** that decide who can do
what, the **template fields** you fill in when you build a template, and a small **settings
form** for logging. MimeMail adds a couple of extra options when present.

## Permissions (read this first)

Set these on **People → Permissions**:

| Permission | What it does |
|---|---|
| **Add PET entity** | Create templates. |
| **View PET entity** | View a template **and reach the interactive send form** at `/pet/{template}` and the template list. |
| **Edit PET entity** | Edit templates. |
| **Delete PET entity** *(restricted)* | Delete templates. |
| **Administer PET entity** *(restricted)* | The settings form (below). |
| **Administer previewable email templates** *(restricted)* | Reveals the From / CC / BCC / recipient-callback "Additional options" on the template form. |

> **Note:** the interactive send page requires *View PET entity*, so grant it only to roles
> that should be able to send template email.

## Building a template

At **Structure → PETs** (`/admin/structure/pets`) you add, edit, clone, and export templates.
A template's fields are:

- **Title** *(required)* — an admin-facing name for the template (not shown in the email).
- **Machine name** — used to refer to the template from code and in the send URL
  (`/pet/<name>`).
- **Subject** *(required)* — the email subject; may contain tokens.
- **Mail body** — the HTML/markup body; may contain tokens.
- **Plain-text body** — used with MimeMail; if left blank, the HTML is converted automatically.
- **Send plain only** — send only plain text (MimeMail).
- **From override** — overrides the site's default From address for this template.
- **CC default / BCC default** — default CC/BCC recipients (comma- or line-separated).
- **Recipient callback** — the name of a function that returns the recipient list dynamically
  when no explicit user is given.

The From / CC / BCC / recipient-callback fields sit under an **Additional options** section
that only appears for users with *Administer previewable email templates*.

## Sending a template interactively

Visit `/pet/{template}` (needs *View PET entity*). It's a two-step form: step one collects the
recipients (or uses the recipient callback, or a `?uid=` / `?nid=` value in the URL) and lets
you edit the subject and body for this single send without changing the stored template; step
two shows the **token-substituted preview**; submitting sends the mail. Add `?uid=17` to pull a
specific user's tokens, or `?nid=244` to bring in node tokens.

## The settings form

At **Configuration → System → PET settings** (`/admin/config/system/pet/settings`, permission
*Administer PET entity*) there is a single **logging** option:

- **Log everything** — record both successful sends and errors.
- **Errors only** — log only failures.
- **No logging, show errors on screen** — useful while debugging.

## MimeMail

When the MimeMail module is enabled, the template form and preview expose the plain-text body
and "send plain only" options, and MimeMail assembles the multipart (HTML + plain-text)
message. Without MimeMail, only the single body is used.
