# Postal Mail Delivery Platform Integration — manual setup guide

**Postal Mail Delivery Platform Integration** (`postal_mail`) sends your site's outbound email
through [Postal](https://github.com/postalserver) — a complete, open‑source mail delivery
platform you can run on your own servers (think Sendgrid, Mailgun, or Postmark, but
self‑hostable). It plugs into Drupal through the **Mail System** module as a mail plugin, so
you can make Postal the default mail system for the whole site or route only specific modules
through it. The payoff is better deliverability and delivery tracking for transactional email.

The module also exposes an optional **webhook** endpoint so Postal can report delivery status
back to Drupal, and it dispatches an event your custom code can subscribe to when a webhook
arrives.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it
   alongside Mail System.

The module's settings and Mail System wiring are covered under "Where it lives" and "How to
use it" below.

## Where it lives in the admin menu

- **Postal settings** — `/admin/config/services/postal` (protected by the **Administer postal
  mail** permission). This is where you enter your Postal API credentials and the webhook
  secret.
- **Mail System configuration** — `/admin/config/system/mailsystem`, where you choose Postal
  as the site's default mail system or assign it to specific modules.

## How to use it

1. On **`/admin/config/services/postal`**, enter your **Postal API credentials** (the API key
   and the Postal server/host details) and, if you want delivery tracking, a **webhook secret
   key**.
2. On **`/admin/config/system/mailsystem`**, set **Postal Mail Delivery Platform** as the
   default mail system for both the *formatter* and the *sender* — or assign it only to the
   specific modules whose mail you want to route through Postal.
3. (Optional) Configure the matching webhook in your Postal account to call
   **`/postal/webhook`** on your site. The endpoint is protected by the secret key you set in
   step 1. When a webhook is received, the module dispatches a
   `\Drupal\postal_mail\Event\WebhookEvent` that custom code can subscribe to; site builders
   can alternatively use the contributed **Webhooks** module for a UI‑driven approach.

### A note on credentials

Your Postal API credentials let anything holding them send mail as your platform, so treat them
as secrets. Rather than committing them to exported configuration, store the value in an
environment variable (with DDEV, `ddev dotenv set .ddev/.env --postal-api-key=…` then
`ddev restart`) and reference it through a **Key** entity where the form supports one. All
traffic to Postal should use HTTPS.
