# Send Emails — manual setup guide

**Send Emails** (`send_emails`) gives you a friendly admin interface for creating
and editing email templates, plus a service that other code calls to actually send
them. The idea is that instead of hard‑coding notification emails in custom code
(or wiring up Rules), a developer defines the email once and a **non‑technical
editor** can then maintain the subject and body through the UI — no code change
needed each time the wording is tweaked.

Each email you define has a subject, an HTML body, a "reply to" address, and an
optional URL used for an auto‑login link. Both subject and body support **Twig
variables**, so a template can include things like the recipient's name, an
auto‑login link, the site name, the front‑page URL, a timestamp, the user entity,
and any custom variables the calling code passes in. To send an email you call the
`send_emails.mail` service from your own code — for example
`notifyUser($user, $template, …)` to email one user, or
`notifyUsersByRole($role, $template)` to email everyone in a role.

Two optional submodules extend it: **Send Emails - Attachments**
(`send_emails_attachments`) adds file attachments, and **Send Emails - Manual**
(`send_emails_manual`) adds a UI to manually send a template to everyone in a role
(at `/admin/config/send_emails/manual/[template]`). The module provides its own
permissions and works on Drupal 8.8 through 11.

A note on responsible use: a system that sends email is powerful. Gate its
permissions — especially the manual‑send submodule — to trusted operators so it
can't become a spam or relay vector, keep the recipient and content sources
trusted, and treat any recipient lists as personal data. The module has no
access‑control role beyond its own permissions, and it is not covered by Drupal's
security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the Send Emails settings page and how
   to define an email template, field by field.

## Where it lives in the admin menu

Once enabled, you manage email templates under **Configuration → Send Emails
Configuration** at `/admin/config/send_emails/emails`. If you enable the manual
submodule, you can send a template to a role from
`/admin/config/send_emails/manual/[template_machine_name]`.
