# Mail System — manual setup guide

**Mail System** (`mailsystem`) lets you choose which mail plugin *formats* and
which mail plugin *sends* each message Drupal produces — and it lets you make that
choice site-wide, per module, or even per individual mail key. Drupal core normally
lets a single mail plugin format and send every email, and changing it means
overriding the `mail_system` container parameter in code. Mail System replaces that
with an admin form where you pick a **formatter** and a **sender** for the site
default and, optionally, override them for specific modules or mail keys.

On its own, Mail System does not send email any differently than core — it is the
**plumbing** that other mail modules plug into. Modules such as Symfony Mailer, SMTP,
Swift Mailer, Mime Mail, and Mailgun register formatter and sender plugins, and this
form is where you wire those plugins up: for example, format newsletters with an HTML
formatter while sending everything through an SMTP transport. Settings are stored as
exportable configuration, so your mail routing deploys cleanly between environments.

This guide is written for a **human** clicking through the admin UI. If you are
looking for terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Configure the Mail System settings page](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits on one page: **Configuration → System → Mail System**
(`/admin/config/system/mailsystem`). Its two sections are:

- **Default Mail System** — the formatter, sender, and theme used for all mail unless
  an override matches.
- **Module-specific configuration** — optional overrides that route a particular
  module's mail (and, optionally, a specific mail key) through different plugins.

Access to the page is gated by the **Administer Mail System** (`administer_mailsystem`)
permission.

## Contents

1. [Installation](installation/index.md) — install Mail System with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the site-wide default formatter and
   sender, and add per-module or per-key overrides.
