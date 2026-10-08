# Elastic Email — manual setup guide

**Elastic Email** (`elastic_email`) routes your site's outgoing email through the
[Elastic Email](https://elasticemail.com) transactional email service instead of
your server's own local mail (sendmail/postfix) or SMTP. Rather than opening an
SMTP port and configuring a mail server, the module hands each message to Elastic
Email's HTTP API over HTTPS (port 443), which is especially handy on cloud hosts
that block outgoing SMTP or whose IP ranges get caught by spam filters.

Elastic Email does **not** replace Drupal's mail system on its own — it plugs into
the [Mailsystem](https://www.drupal.org/project/mailsystem) module (its one
dependency) and provides a mail plugin (`elastic_email_mailsystem`) that you point
Mailsystem at, site-wide or for a single module. Once wired up, mail you would
normally send is delivered through your Elastic Email account, identified by an API
username and an account API key.

It needs configuration before it will do anything: you enter your Elastic Email
credentials on its settings form, optionally set a default channel, a reply-to
override, message queueing (so mail is sent on cron rather than synchronously),
delivery logging, and a low-credit warning threshold. A built-in dashboard shows
your account and credit status, and a "Test Email" form lets you confirm the
credentials work before you rely on them. Note this version does not support email
attachments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pull in the Mailsystem dependency.
2. [Configuration](configuration/index.md) — enter your API credentials, wire up
   Mailsystem, and send a test message, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Elastic Email settings**
(`/admin/config/system/elastic_email/settings`), and the account dashboard is at
`/admin/config/system/elastic_email`. Both are gated by the **Administer site
configuration** permission. Mailsystem's own routing lives separately at
**Configuration → System → Mailsystem** (`/admin/config/system/mailsystem`).
