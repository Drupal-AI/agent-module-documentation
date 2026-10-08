# Mail Box Management — manual setup guide

**Mail Box Management** (`mail_box_management`) brings **IMAP email integration**
into Drupal. It connects your site to an IMAP mailbox and lets you fetch, display,
and organise the emails in it — subject, sender, body, and attachments — and it
can also **send** and **reply** to messages. That makes it a foundation for
workflows such as support ticketing, where incoming email needs to become
something Drupal can act on, or for keeping an in‑site inbox/outbox.

Its headline features are: securely connect to one IMAP mailbox; fetch emails
(including attachments); display and organise the fetched messages; process them
with custom workflows for notifications or content; and send and reply to mail.

Setup is essentially one configuration step: after enabling the module, go to its
configuration page and enter your IMAP server details — hostname, port, whether to
use SSL/TLS, username, and password — then complete the setup.

> **Handle the mailbox credentials and contents with care.** The IMAP username and
> password are secrets: store them securely, connect over an **encrypted (SSL/TLS)**
> connection, and never commit the credentials to your repository — prefer an
> environment variable, as the [Configuration](configuration/index.md) page
> describes. Mailbox contents are private correspondence and may contain personal
> data (PII), so gate the module's permissions to the appropriate users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your IMAP server details
   (stored securely) and complete the setup.

## Where it lives in the admin menu

The configuration lives under **Configuration → Mail Box Management**, at
`/admin/mailbox-management/configuration`.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Mail Box Management** and enter your IMAP server
   details — hostname, port, SSL/TLS, username, and password — then complete the
   setup at `/admin/mailbox-management/configuration` (see
   [Configuration](configuration/index.md)).
3. Once connected, fetch emails from the mailbox, display and organise them, and
   send or reply as your workflow requires.
