# Acquia Connector — manual setup guide

**Acquia Connector** (`acquia_connector`) links a Drupal site to an **Acquia
Cloud subscription** so the site can securely communicate with Acquia's hosted
network services. Once connected, it authenticates the site to those services,
exposes a status endpoint that Acquia's uptime monitoring can poll, and sends
anonymized telemetry (the list of enabled modules and their versions, PHP and
Drupal versions, and a hashed site UUID) back to Acquia.

You connect the site from the settings page in one of two ways: an **OAuth flow**
("Connect to Acquia Cloud"), or by **pasting subscription credentials** manually
(an identifier, a secret key, and an application UUID). Importantly, those
credentials are **never stored in Drupal's exported configuration** — they are
resolved at runtime from environment variables (automatic on Acquia hosting),
`settings.php`, or Drupal state. The settings config object only holds a few
behavior options (debug logging, cron interval, whether to hide signup messages).

This module is primarily useful if you host on **Acquia Cloud** or use other
Acquia product modules, which rely on Connector's subscription service to know
whether the subscription is active. It has no hard module dependencies (though the
Key module is used for legacy network keys on Acquia hosting), provides its own
permissions and Drush commands, and adds a toolbar item. Telemetry is only sent
from a detected Acquia production environment, throttled to once per 24 hours.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect to a subscription (OAuth or
   manual credentials), where credentials come from, and the settings options.

## Where it lives in the admin menu

The connector lives at **Configuration → Services → Acquia Connector**
(`/admin/config/services/acquia-connector`). The connect / OAuth / manual‑credential
and refresh routes all sit under that path, and all require the **Administer site
configuration** permission. A toolbar item is also available to users with the
connector's toolbar permission.

## How to use it

1. Install and enable the module.
2. Go to **Configuration → Services → Acquia Connector** and connect the site —
   either through the OAuth "Connect to Acquia Cloud" flow or by entering your
   subscription credentials manually.
3. Once connected, the subscription status is available to the site and other
   Acquia modules, the status endpoint at `/system/acquia-connector-status` is
   live for monitoring, and telemetry is sent from production Acquia environments.

See [Configuration](configuration/index.md) for the connection steps and options.
