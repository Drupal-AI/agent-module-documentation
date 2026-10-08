# HubSpot connect — manual setup guide

**HubSpot connect** (`hubspot_connect`) adds HubSpot's tracking JavaScript to
every page of your site, so visitor activity is recorded in HubSpot for
analytics, marketing automation, and CRM. HubSpot gives you a snippet and tells
you to paste it somewhere — but pasting raw script into a block is a poor fit for
Drupal: Drupal isn't aware of the library, the script bypasses Drupal's rules for
loading, caching, and aggregation, and it can clash with other scripts. HubSpot
connect instead registers the tracking code as a proper Drupal library so it
loads the right way.

Setup is minimal: install the module and enter your **HubSpot tracking ID**
(portal ID). From then on the tracking script is attached to your pages.

Like any third‑party marketing tracker, this has privacy implications — it loads
external JavaScript that tracks visitors and can set cookies — so treat it as a
consent‑and‑disclosure matter, not just a technical toggle. See the configuration
guide for the details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your HubSpot tracking ID and
   the privacy/consent considerations.

## Where it lives in the admin menu

The settings form is provided by the module's `hubspot_connect.settings` route,
where you enter the HubSpot tracking ID. See
[Configuration](configuration/index.md).
