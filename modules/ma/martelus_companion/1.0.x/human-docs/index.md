# Martelus Companion — manual setup guide

**Martelus Companion** (`martelus_companion`) installs **Vectorly AI** on your
Drupal site — an AI‑powered assistant for business tasks such as customer‑service
automation, product insights, and competitive pricing. It integrates the Martelus
AI service into Drupal so you can add an intelligent chatbot and related
commerce‑intelligence features to your site.

The module is the connector; the intelligence runs as a hosted service. Using it
**requires a paid subscription** to Vectorly AI from the
[Martelus store](https://martelus.store/products/vectorly-ai), and its use is
governed by the Martelus [terms of service](https://martelus.store/terms-of-service).
You can see a live demo at [martelus.store](https://martelus.store).

Because Martelus Companion talks to an external AI service, two things follow. The
**API credentials** it uses are admin‑configured and should be stored securely (in
an environment variable rather than in the database or version control). And,
because customer conversations and business data are sent to Martelus for
processing, it is a **data‑egress and privacy** consideration — disclose it and
obtain consent where your rules require. Martelus Companion supports Drupal 8
through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect the module to your Vectorly AI
   subscription and store the credentials safely.

## Where it lives in the admin menu

After enabling, you connect the module to Martelus by entering your Vectorly AI
credentials on the module's settings form (in the **Configuration** area). You will
need an active paid subscription for the connection to work.
