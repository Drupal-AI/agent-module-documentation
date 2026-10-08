# Seers Cookie Consent Banner — manual setup guide

**Seers Cookie Consent Banner** (`gdpr_ccpa_cookie_consent_seers`) integrates the
**Seers** Cookie Consent Management Platform (CMP) into your Drupal site. It adds
the Seers‑powered cookie consent banner to your pages so you can record visitor
consent for cookies and trackers and work toward GDPR, ePrivacy, and CCPA
compliance. The banner itself — its layout, styling, cookie scanning, and consent
records — is managed in your Seers account; this module's job is to load the Seers
script into your site's header.

To use it you connect a **Seers account**: you create the banner in Seers, obtain
its embed script or site identifier, and provide that to the module so it renders
on your site.

> **Third‑party service and privacy note.** This module loads a script from Seers,
> a third‑party SaaS. That means visitor page loads reach out to Seers' servers,
> and consent data is handled by Seers rather than stored solely on your site.
> Factor that egress and data‑processing relationship into your own privacy policy
> and any data‑processing agreements. Keep any account credentials you receive from
> Seers secure — store secrets in environment variables, never in committed
> configuration or version control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Seers account so the
   banner loads.
