# SendEthic — manual setup guide

**SendEthic** (`sendethic`) integrates the SendEthic email/marketing delivery
platform with Drupal. It gives developers a service to send email or sync
marketing data through SendEthic's API, and it ships a **Webform handler** so you
can wire a webform's submissions straight to SendEthic without writing code.

The usual setup is short: install the module, store your SendEthic API
credentials, then add the SendEthic handler to whichever webforms should feed the
platform. Once connected, form submissions (or programmatic calls) are sent on to
SendEthic.

Because the credentials authenticate all of your SendEthic traffic, store them
securely. The maintainers recommend using the **Key** module to hold them
(env‑backed), rather than pasting them into plain configuration. Administration is
gated by the `administer sendethic configuration` permission, so only trusted
roles can change the connection. SendEthic requires a SendEthic account and API
key, runs on Drupal 9, 10, and 11, is minimally maintained, and is not covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your SendEthic credentials and
   add the webform handler.

## How to use it

After enabling, set your SendEthic API credentials (via the settings form or,
recommended, the Key module), then attach the **SendEthic** handler to a webform
under **Structure → Webforms → [your form] → Settings → Emails / Handlers**. From
then on, submissions to that form are delivered to SendEthic.
