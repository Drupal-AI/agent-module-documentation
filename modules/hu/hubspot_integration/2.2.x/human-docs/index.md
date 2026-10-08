# Hubspot Integration — manual setup guide

**Hubspot Integration** (`hubspot_integration`) is a functional integration
between Drupal and HubSpot's CRM and marketing platform. It does three related
things: it lets you **embed HubSpot forms and behaviour** in content (through
Field API fields, widgets, and formatters, plus a JavaScript block); it **maps a
visitor's HubSpot contact data onto Drupal taxonomy terms**; and it drives
**persona‑based personalisation** using a cookie, so you can tailor and filter
content to who the visitor is according to HubSpot.

Under the hood, a service reads HubSpot's `hubspotutk` tracking cookie, looks up
the visitor's contact profile through the HubSpot Contacts API, and derives a set
of taxonomy term IDs that represent that contact. You then use those term IDs in
Views — as a contextual filter, a default argument, or a sort — to personalise
what visitors see. A small set of AJAX endpoints let the front end check whether
the current visitor is a known contact and set a persona cookie.

Because it embeds forms and personalises content, it depends on the **Paragraphs**
and **Entity Reference Revisions** modules, which it uses to build the
personalised sections.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies and enable it.
2. [Configuration](configuration/index.md) — enter your HubSpot API key, map
   contact data to taxonomy, and set the sort order.

## Where it lives in the admin menu

The module's admin screens live under **`/admin/config/hubspot_integration`**
(the `hubspot_integration.admin` route), which groups the **Settings**,
**Mapping**, and **Sort** forms. Everything there is gated behind the
**Administer hubspot integration** permission. See
[Configuration](configuration/index.md).
