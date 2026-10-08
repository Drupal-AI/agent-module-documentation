# GCLID — manual setup guide

**GCLID** (`gclid`) captures the **Google Click ID** — the ad‑click identifier
Google Ads appends to a landing‑page URL when someone clicks an ad — stores it for
the visitor, and then auto‑populates configured form fields with it. That lets a
conversion submitted through a Drupal form be tied back to the ad click that
brought the visitor in, which is the basis for **offline conversion tracking**.

A typical setup looks like this: Google Ads sends the GCLID as a URL query
parameter; your forms contain a hidden GCLID field; this module transfers the
visitor's captured GCLID into that hidden field; and the form submission (with the
GCLID) is forwarded to a CRM that reports the conversion back to Google Ads. The
**Google Tag** and **Webform** modules pair well with this workflow.

Because the GCLID is a marketing identifier tied to an individual visitor, handle
it in line with your site's privacy policy and consent requirements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which fields to populate, set
   the expiration, and pick the roles it applies to.

## Where it lives in the admin menu

After installation, configure it under **Configuration → Web services** — look for
**Configure GCLID settings**. Access is gated by the **Administer GCLID settings**
permission.
