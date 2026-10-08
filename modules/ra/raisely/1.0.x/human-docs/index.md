# Raisely — manual setup guide

**Raisely** (`raisely`) integrates Drupal with the **Raisely** fundraising and
donation platform through the Raisely API. It connects your site to Raisely so that
campaigns, donations, and related data can be fetched and displayed — or synced — on
your Drupal site, which is useful for nonprofits running their fundraising on Raisely.

The module is in **active development**, so its feature set is still growing. At its
core, you supply Raisely API credentials, and the module uses them to talk to the
Raisely API on your behalf.

> **Secrets and data egress:** the Raisely API credentials are entered by an
> administrator and should be stored securely (backed by an environment variable),
> never committed to version control. Because the module talks to an external
> platform, data flows to and from Raisely — confirm that is acceptable for the
> information involved, and make sure the site runs over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enter your Raisely API credentials and
   store them safely.

## How to use it

1. Create/obtain your **Raisely API credentials** from your Raisely account.
2. Enter them in the module's settings (see [Configuration](configuration/index.md)).
3. The module then connects to the Raisely API to fetch and surface your campaign and
   donation data on the site.
