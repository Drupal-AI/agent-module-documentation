# Axeptio — manual setup guide

**Axeptio** (`axeptio`) embeds the [Axeptio](https://www.axeptio.eu/) consent
widget into your Drupal site — the cookie/consent banner and preference centre that
asks visitors what tracking they will allow. Axeptio is a French consent‑management
platform, and for organisations subject to **CNIL** enforcement that provenance is
often the point: the data stays in the European Union, the vendor answers to the
same regulator as the site, and the third‑country‑transfer question that has
repeatedly caught US‑hosted tooling does not arise. Axeptio is also known for a
conversational banner design that increases the share of visitors who make an
active choice rather than simply dismissing the banner — and an unanswered banner
is not consent.

This module supplies the integration. It is version **2.1.0**, runs on Drupal 9.2,
10, or 11, and its settings live behind an **`administer axeptio`** permission.

The most important thing to understand about any consent platform is this: **the
banner is the easy half.** What actually decides compliance is whether your
trackers are genuinely held back until consent is given. A site that shows a
consent widget while its analytics tag, video embeds, social buttons and maps all
keep loading unconditionally has bought a banner and nothing else. So the real work
is: inventory **every** script on the site — including ones added by modules, not
just by a tag manager — and gate each one behind consent; and watch the **page
cache**, because a consent decision is per visitor, and a page cached with a script
tag baked into it will serve that script to everyone regardless of what they chose.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Axeptio account and the
   critical step of gating your trackers.

## Where it lives in the admin menu

Axeptio adds a settings form controlled by the **`administer axeptio`**
permission, where you enter the identifiers from your Axeptio account so the widget
loads on your site. See [Configuration](configuration/index.md).
