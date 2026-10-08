# Eulerian — manual setup guide

**Eulerian** (`eulerian`) integrates the **Eulerian** analytics and marketing
attribution platform with your Drupal site. It adds Eulerian's tracking to your
pages so visitor behaviour is sent to Eulerian for analytics and attribution, and —
through optional Commerce submodules — reports e‑commerce events such as cart,
checkout and product interactions.

The base module is a capable tracker: single‑domain tracking, selectively
tracking or excluding pages, custom variables via tokens, site‑search and modal
(Colorbox) tracking, 403/404 tracking, cross‑device user‑ID tracking, asynchronous
loading, a data‑cleaning system following Eulerian's recommendations, and Eulerian
Tag Manager support. It depends on core's **Path Alias** module.

Because it sends visitor (and, for Commerce, purchase/behaviour) data to a
third‑party platform, it carries privacy and consent obligations: obtain
appropriate consent, integrate it with your cookie‑consent mechanism, and disclose
the tracking. Eulerian publishes separate
companion modules for consent managers — **Eulerian Tarte au Citron** (for Tarte au
Citron) and **Eulerian TacJS** (for TacJS) — which you can add to gate the tracker
behind consent. The module has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the Commerce submodules you need.
2. [Configuration](configuration/index.md) — enter your Eulerian domain and choose
   what to track.

## Where it lives in the admin menu

The settings form is at Eulerian's settings page (`eulerian.settings_form`) under
**Configuration**.

## How to use it

Enter your Eulerian website domain on the settings form and choose which pages and
events to track. If you run Drupal Commerce, enable the `eulerian_commerce_*`
submodules to also send cart, checkout and product events. To stay compliant, pair
Eulerian with a consent manager (Tarte au Citron or TacJS) using the companion
module so the tracker only loads after consent.
