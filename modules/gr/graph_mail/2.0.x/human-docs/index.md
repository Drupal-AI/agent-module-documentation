# Graph Mail — manual setup guide

**Graph Mail** (`graph_mail`) is a Drupal mail backend that sends your site's outgoing
email through the **Microsoft Graph API** instead of PHP's `mail()` function or an SMTP
relay. If your organization runs Microsoft 365 / Exchange Online, this lets you deliver
registration mails, password resets, contact-form messages, and other transactional email
straight from a Microsoft 365 mailbox — no SMTP passwords to store, no third-party relay to
trust. It authenticates with an **Azure app registration** using app-only OAuth2
(client-credentials), so no interactive user login is ever needed to send.

The module registers a `graphmail` mail plugin that Drupal's mail system can use for some or
all outgoing mail. It sends HTML-formatted messages with CC, BCC, Reply-To, and file
attachments, and can optionally keep a copy in the mailbox's **Sent Items** folder. If
Microsoft throttles a send (HTTP 429), the message is re-queued and retried automatically on
cron, honoring Microsoft's `Retry-After` delay — so occasional rate-limiting doesn't lose
mail.

It has no Drupal module dependencies, but it does require the `microsoft/microsoft-graph`
PHP SDK (pulled in by Composer). Pairing it with the **Mailsystem** module is recommended,
because Graph Mail does not force itself as the site's default sender — Mailsystem gives you a
UI to pick Graph Mail globally or for specific mail keys.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the Graph PHP SDK) with
   Composer and enable it.
2. [Configuration](configuration/index.md) — the Azure app registration, the settings form
   field by field, choosing Graph Mail as the mail backend, and the retry queue.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Graph Mail**
(`/admin/config/services/graph_mail`). You need the *Administer Graph Mail configuration*
permission to reach it. If you use Mailsystem, you'll also select Graph Mail at
**Configuration → System → Mailsystem** (`/admin/config/system/mailsystem`).

## How to use it

Getting Graph Mail delivering involves three broad steps, all covered in detail on the
[Configuration](configuration/index.md) page:

1. **Set up an Azure app registration** with the **Mail.Send** *application* Graph permission
   (admin-consented) and a client secret.
2. **Enter the credentials** (tenant ID, client ID, client secret, the sending mailbox) on the
   Graph Mail settings form.
3. **Select Graph Mail as the mail backend**, ideally via the Mailsystem module, either
   site-wide or for specific modules/mail keys.

Once that's done, mail Drupal sends through the configured keys is delivered via Microsoft
Graph. You can also send ad-hoc messages from custom code using the `graph_mail.helper`
service.
