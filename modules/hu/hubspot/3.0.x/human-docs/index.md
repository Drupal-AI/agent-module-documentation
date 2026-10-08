# HubSpot Webform integration — manual setup guide

**HubSpot Webform integration** (`hubspot`) connects your Drupal site to HubSpot.
It does two main things: it sends **Webform** submissions into HubSpot as form
submissions/leads through HubSpot's Forms API, and it can inject HubSpot's
JavaScript **tracking code** across your whole site so HubSpot's analytics see
your visitors.

The module authenticates to HubSpot with **OAuth 2**. You create a HubSpot app,
enter its Client ID, Client Secret, and your Portal (Hub) ID on the settings page,
then click **Connect HubSpot Account** to authorize. Drupal stores the resulting
access and refresh tokens and transparently refreshes the access token whenever it
expires, so once you've connected you don't have to think about it again.

The heart of the integration is a **Webform handler** called *HubSpot Webform
Handler*. Add it to any webform, pick which HubSpot form to target from a
live‑loaded list, and map each webform element to a HubSpot field. It handles the
fiddly bits for you: uploaded files are pushed to HubSpot's file API, entity
references become labels, multi‑value fields become semicolon‑separated lists, and
the visitor's HubSpot tracking cookie, IP address, and referring page are passed
along so submissions attach to the right contact. You can also map GDPR
legal‑consent and email‑subscription opt‑ins. An optional block can show recent
HubSpot leads to trusted users.

It is built on the official `hubspot/hubspot-php` client and depends on the
**Webform** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (the HubSpot PHP
   client comes along), enable it, and the Webform requirement.
2. [Configuration](configuration/index.md) — the settings form, connecting via
   OAuth, the tracking code toggle, and adding the Webform handler.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → HubSpot**
(`/admin/config/services/hubspot`). You add the Webform handler from an individual
webform's own **Settings → Handlers** screen.
