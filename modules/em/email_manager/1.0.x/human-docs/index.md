# Email Manager — manual setup guide

**Email Manager** (`email_manager`) lets site builders customise the **subject and
HTML body of Drupal's outbound emails from the admin UI** instead of in code.
Normally the wording of a Drupal email (user registration, password reset, and so
on) is baked into a module's `hook_mail()` implementation; Email Manager
intercepts those messages and swaps in an admin‑authored template, so you can
brand and rewrite transactional emails without touching PHP.

It works through two configuration entities and a mail plugin. An **Email Key**
identifies a specific message as a `module:key` pair (for example
`user:register_no_approval_required`) — keys are auto‑discovered, and developers
can add any the discovery misses. An **Email Template** binds to a key and stores
a subject plus a rich‑text body you edit in **CKEditor**, with full **token**
support (including the module's own `email_manager:module` and `email_manager:key`
tokens). At send time, the module's mail plugin (`EmailManagerMail`) looks up the
template for a message's module/key, replaces the tokens, and renders the body as
HTML.

The module depends on core's **Node**, **Token**, **Editor**, and **CKEditor**
modules. Everything is gated behind the **Administer email templates** permission
(marked restricted), and it adds no public endpoints — grant that permission only
to trusted administrators, since templates are HTML rendered straight into
outbound mail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the mail plugin, define keys,
   and author templates.

## Where it lives in the admin menu

- **Templates:** **Configuration → System → Email Manager**
  (`/admin/config/system/email-manager`) — list, add, and edit templates.
- **Keys:** `/admin/config/system/email-manager/keys` — list and manage the
  `module:key` pairs.

Both require the **Administer email templates** permission.
