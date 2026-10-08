# Media/Document Notifier — manual setup guide

**Media/Document Notifier** (`custom_email_notify`) emails a set of recipients
whenever a file with a matching extension is uploaded to the site. You give it a list
of extensions to watch (for example `pdf,docx`) and a list of addresses; from then on,
each time a file with one of those extensions is saved, everyone on the list gets a
notification. It's the simple answer to "let the compliance inbox know whenever a
document is added" or "ping the team when a new PDF lands."

Under the hood it hooks into file creation: when a new file entity is saved, the
module compares its extension against your allow‑list and, on a match, sends a mail
through Drupal's normal mail system to each configured address. The message subject
and body come from configuration, and the body supports two placeholders —
`[file_url]` (the absolute URL of the uploaded file) and `[current-username]` (the
name of the account that uploaded it).

Because the settings control who receives outbound mail and what it says, the
configuration is gated by a dedicated, *restricted* permission — **`administer media
document notifier`** — which you should grant only to trusted administrators. The
settings form validates its inputs carefully: extensions must be bare alphanumeric
tokens, every recipient must be a valid email address, and the subject must be
non‑empty and free of line breaks (a guard against email‑header injection). The
module depends on core's **File** and **Media** modules and works on Drupal 10 and 11.

> **Heads‑up on the package name:** the module's machine name is `custom_email_notify`,
> but its Composer/project name is **`medianotify`**. Use `composer require
> drupal/medianotify` to install it, and `drush en custom_email_notify` to enable it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media/Document Notifier
settings** (`/admin/config/custom-email-notify/settings`, route
`custom_email_notify.settings_form`), behind the **`administer media document
notifier`** permission.
