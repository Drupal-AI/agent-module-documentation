# Scaleflex DAM (Filerobot) — manual setup guide

**Scaleflex DAM (Filerobot)** — machine name `filerobot`, Composer package
`drupal/filerobot_by_scaleflex` — integrates the
[Scaleflex Filerobot](https://www.scaleflex.com/) Digital Asset Management (DAM)
platform with Drupal. Filerobot is a hosted, scalable DAM with image and video
optimizers for storing, organizing, optimizing, and delivering media assets. With
this module, editors can browse and pick assets from your Filerobot account and
insert them into Drupal as files or media.

Because Filerobot is a **software‑as‑a‑service** platform, the module connects to
your Filerobot account over the network using **API credentials**. Those
credentials are sensitive: treat them like any other secret and store them in an
environment variable (and, where supported, a Key entity) rather than pasting them
into configuration that gets exported and committed — see
[Configuration](configuration/index.md).

Asset insertion is gated behind the core **Administer media** permission, so only
trusted content administrators should have it. One operational caution worth knowing:
the module's insert endpoint fetches an asset by URL on the server side, so keep the
**Administer media** permission restricted to people you trust, and be aware that the
module reaches out to Filerobot (and to asset URLs) from your server.

Scaleflex DAM works on **Drupal 10 and 11** and provides its own permissions.

> **Note:** This module talks to a third‑party SaaS. Review Scaleflex's terms and
> your data‑handling requirements before sending assets to it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the package
   name differs from the machine name) and enable the module.
2. [Configuration](configuration/index.md) — connect to your Filerobot account and
   store the API credentials securely.

## How to use it

1. Sign up for a Scaleflex Filerobot account and obtain your API credentials.
2. Install and enable the module, then connect it to your account (see
   [Configuration](configuration/index.md)).
3. Grant **Administer media** to the trusted editors who should be able to insert
   Filerobot assets.
4. When editing content or media, use the Filerobot picker to choose an asset and
   insert it as a Drupal file/media.
