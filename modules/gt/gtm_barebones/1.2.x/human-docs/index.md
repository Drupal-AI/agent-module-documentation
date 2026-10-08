# Barebones GTM — manual setup guide

**Barebones GTM** (`gtm_barebones`) is a deliberately minimal **Google Tag
Manager** integration. It does one thing: inject the essential GTM container
snippet into your pages. There is none of the extensive configuration you find in
larger GTM or analytics modules — you give it a container ID and it adds the
snippet. Browsers then request the GTM scripts directly from Google, exactly as
Google supplies them; there is no server‑side script caching. If you have a
Content‑Security‑Policy module installed, the module wires itself into it
automatically.

Use it when you want GTM on the site with as little overhead as possible and you
manage everything else — the actual tags, triggers, and variables — from the GTM
console rather than from Drupal. The module has no access‑control role of its own.

**A word on privacy and consent.** Like any tag manager, GTM can load third‑party
tracking scripts and set cookies. Pair Barebones GTM with proper cookie‑consent
handling and disclose the tracking as your jurisdiction requires. Remember that
what actually loads is decided in the GTM console, not in Drupal, so your consent
strategy has to account for whatever tags your marketing team configures there.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP 8.2
   requirement, and enable the module.

## Configuration

Barebones GTM has no elaborate settings screen — the configuration is just your
GTM **container ID** (the `GTM-XXXXXXX` value) and the keys/auth needed to load
it. Enter your container ID as described in the module's `README.md` after
installing, and the snippet is injected from then on. Because the configuration is
this small, there is no separate configuration guide — set the container ID and
you are done.

## How to use it

1. Create (or obtain) a Google Tag Manager **container** and note its ID.
2. Enter that ID in the module's configuration per the `README.md`.
3. Define your actual tags, triggers, and variables in the **GTM console** — not
   in Drupal.
4. Make sure a **cookie‑consent** mechanism is in place before your tags start
   setting tracking cookies, and disclose the tracking to visitors.
