# Clickio Consent — manual setup guide

**Clickio Consent** (`clickioconsent`) connects your Drupal site to the **Clickio
Consent** management platform (a CMP) so you can present a cookie-consent banner and
comply with GDPR, the IAB Transparency & Consent Framework (TCF), and Google's
Consent Mode v2. Clickio is a hosted, Google- and IAB-certified service; this module
is the fast way to wire it into Drupal — you enter your Clickio site ID and the
module loads Clickio's script, which then runs the consent banner and logic in your
visitors' browsers.

Setup is deliberately minimal: enter your Clickio site ID and you're compliant "in
minutes," as the project puts it. It works on Drupal 8 and later.

There is one important thing to understand before using it, because it involves a
third party. The module **loads a script from Clickio** into every visitor's
browser, and the Clickio CMP processes your visitors' consent data. That means:

- You are sending page traffic to and running third-party code from Clickio, so
  **vet Clickio as a data processor** and **disclose it in your site's privacy
  policy** — the same due diligence any external CMP requires.
- The Clickio **site ID is ordinary configuration, not a secret**. It identifies
  your Clickio property and is fine to store in Drupal config and commit with your
  configuration; it does not need a Key entity or an environment variable. (If you
  ever integrate a component that *does* use a genuine API secret, store that in an
  environment variable via DDEV's dotenv and reference it through a Key entity —
  but that is not needed for this module.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — entering your Clickio site ID.

## Where it lives in the admin menu

Clickio Consent provides a settings form where you enter your Clickio site ID. See
[Configuration](configuration/index.md) for how to reach it and what to fill in.
