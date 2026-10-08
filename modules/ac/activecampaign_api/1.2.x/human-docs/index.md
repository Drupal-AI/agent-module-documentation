# ActiveCampaign API — manual setup guide

**ActiveCampaign API** (`activecampaign_api`) is the base connectivity layer
between Drupal and **ActiveCampaign** (the email-marketing and CRM-automation
platform). Rather than being a feature you use directly, it is the plumbing:
other modules or your own custom code use it to sync contacts, manage lists, and
trigger automations through the ActiveCampaign API.

Think of it as the client library plus the settings that hold your credentials.
Install it when another module lists it as a dependency, or when you are building
a custom ActiveCampaign integration and want a ready-made client to call rather
than writing raw API requests yourself. It runs on Drupal 9, 10, and 11.

Its configuration is credential-based: you provide the ActiveCampaign API
credentials, which should be stored securely (environment-backed, not committed).
Access to those settings is gated by the **Manage ActiveCampaign API settings**
(`manage activecampaign_api settings`) permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — provide the ActiveCampaign
   credentials, stored as secrets, behind the module's settings permission.

## Where it lives in the admin menu

The module exposes a settings area for your ActiveCampaign credentials, reachable
by users who hold the **Manage ActiveCampaign API settings** permission. Because
this is a connectivity layer, the day-to-day work of syncing contacts or
triggering automations is done by whatever module or code consumes this client —
here you only supply the credentials it uses.
