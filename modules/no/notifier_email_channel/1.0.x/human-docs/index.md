# Notifier Email Channel — manual setup guide

**Notifier Email Channel** (`notifier_email_channel`) adds the **email channel**
to the [Notifier](https://www.drupal.org/project/notifier) integration, so
Drupal can deliver notifications by email through **Symfony Mailer**. It gives
Notifier an email transport that sits alongside the chat and SMS channels — so a
message sent through Notifier can go out as an email without the sending code
needing to know that.

This module **depends on Notifier** and requires Drupal **10.3 or newer**.
Because it delivers over Symfony Mailer, its email sending uses whatever mail
transport your site is configured with; the credential that matters here is your
outbound mail (SMTP) configuration, which — like any credential — should be
stored as a secret rather than committed.

One housekeeping note: at the time of writing this module's release is **not
covered by Drupal's security advisory policy**, so weigh that when deciding
whether to rely on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Notifier.
2. [Configuration](configuration/index.md) — how email delivery and its mail
   credentials are handled.
