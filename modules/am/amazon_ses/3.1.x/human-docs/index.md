# Amazon SES — manual setup guide

**Amazon SES** (`amazon_ses`) lets your Drupal site send email through
[Amazon Simple Email Service](https://aws.amazon.com/ses/) (SES v2) instead of
PHP's built‑in `mail()` or an SMTP server. It is a reliable way to deliver
transactional email — password resets, order receipts, notifications — at scale,
and it comes with an admin UI for managing verified sending identities, pacing
sends to stay under your SES rate limit, optionally queueing mail to send on
cron, and viewing your account's send statistics.

Under the hood the module registers a Drupal **Mail plugin** (`amazon_ses_mail`).
Once you select it as your mailer — either as the site‑wide default or, more
commonly, per module via the [Mail System](https://www.drupal.org/project/mailsystem)
module — outgoing mail is handed to SES via the AWS SDK. It supports HTML,
plain‑text, and multipart messages, file attachments, Cc/Bcc, and a Reply‑To
address, and it dispatches a `MailSentEvent` after each successful send so other
code can react.

**Importantly, this module does not store your AWS credentials.** It depends on
the separate [AWS](https://www.drupal.org/project/aws) module, which owns your
AWS access keys and region (as an "AWS profile"). The AWS SDK
(`aws/aws-sdk-php`) is installed by Composer. It works on Drupal 9.1+, 10, and
11, and has no submodules. Enabling the module is not enough on its own — you
must configure AWS credentials, set a From address, verify a sending identity,
and select SES as your mailer before mail flows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the Mail plugin,
message builder, handler, queue worker, and `MailSentEvent` — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the AWS SDK
   with Composer, and enable it.
2. [Configuration](configuration/index.md) — configure AWS credentials, set your
   From address, verify identities, and switch your site over to SES.

## Where it lives in the admin menu

The main settings form is at **Configuration → System → Amazon SES**
(`/admin/config/system/amazon_ses/settings`), with sub‑pages for **Verified
Identities**, a **Test** email form, and **Statistics**. Everything is gated by
the **Administer amazon ses** permission, which is marked security‑sensitive.

## How to use it

The short version: configure the AWS module with your credentials and region;
enable Amazon SES; set a verified From address on the settings form; verify at
least one sending identity; then select the SES mailer (via Mail System or in
`settings.php`). The [Configuration](configuration/index.md) page covers every
step and each setting.
