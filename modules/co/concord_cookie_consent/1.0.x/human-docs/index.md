# Concord Cookie Consent — manual setup guide

**Concord Cookie Consent** (`concord_cookie_consent`) adds a **Concord**
cookie-consent banner to your site, so visitors are prompted to accept or decline
cookies and tracking before those trackers run. It's aimed at GDPR and similar
privacy requirements, connecting your Drupal site to Concord's hosted consent
management platform.

The module works by loading Concord's third-party consent JavaScript into your
pages; the actual banner, consent logging, and tracker-blocking behaviour are
managed by the Concord service. Because it embeds an external script, it needs a
small amount of configuration — you point it at your Concord account/property so
the right banner loads. That settings form is gated by its own permission
(`concord_cookie_consent_settings`), so only trusted administrators can change it.

Two things are worth keeping in mind. First, this is a **third-party integration**:
the consent script runs from Concord's servers and consent data flows to their
platform, so review that data-flow against your privacy policy. Second, a consent
banner only helps if it actually **gates the trackers** you intend to block —
confirm the trackers on your site are held back until the visitor consents.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your Concord account and
   confirm the banner gates your trackers.

## Where it lives in the admin menu

Once enabled, the module exposes a settings form for its Concord connection,
available to users with the **Configure Concord Cookie Consent settings**
permission (`concord_cookie_consent_settings`) from the site's **Configuration**
area. See [Configuration](configuration/index.md) for what to enter there.
