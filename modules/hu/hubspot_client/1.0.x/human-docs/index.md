# HubSpot Client — manual setup guide

**HubSpot Client** (`hubspot_client`) connects Drupal to the HubSpot CRM and
keeps data in sync. Out of the box the base module syncs **Drupal users to
HubSpot contacts**, and two optional submodules extend that: **Commerce**
(`hubspot_client_commerce`) syncs Drupal Commerce orders, order items, and
products to HubSpot deals, line items, and products; **Sync**
(`hubspot_client_sync`) maps existing HubSpot object IDs onto Drupal entities so
the two systems can be reconciled.

It is built on top of the [HubSpot API](../../hubspot_api/3.0.x/human-docs/index.md)
module and the HubSpot API v3 PHP SDK — HubSpot Client provides the sync logic,
while the credential itself lives in HubSpot API's settings. If you only need the
default user‑to‑contact sync, the setup is simply: install and enable the module,
then enter your HubSpot private‑app key in the HubSpot API settings form.

For sites with more specific needs, the module exposes a set of events
(entity‑mapping, field‑mapping, and sync lifecycle events) so a developer can add
custom entities or fields to the sync in their own module — the Commerce
submodule is the worked example of that pattern.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, and enable the submodules you need.

## How to use it

The module itself has **no settings form of its own** — its configuration is the
HubSpot credential (set in the HubSpot API settings form) plus the sync actions
you run:

1. **Enter your HubSpot private‑app key** in the HubSpot API settings form (see
   the [HubSpot API configuration guide](../../hubspot_api/3.0.x/human-docs/configuration/index.md),
   which also covers storing the key securely as an environment variable / Key
   rather than in the database).
2. Go to the sync page at **`/admin/config/system/hubspot-sync`**.
3. If you want to link existing HubSpot objects to Drupal, **sync HubSpot IDs to
   Drupal** first (this is what the Sync submodule enables).
4. **Sync Drupal data to HubSpot** to populate and update HubSpot objects.
5. Keep the module enabled so it continues to create and update HubSpot objects as
   your Drupal data changes.

## Data handling — this sends personal data to HubSpot

HubSpot Client sends contacts, and (with the Commerce submodule) order data — all
personal data — out to HubSpot. Two things follow from that:

- **Disclose the transfer** in your privacy policy; contact and order data is
  leaving your site for a third‑party processor.
- **Protect the credential.** Authenticate over HTTPS and store the HubSpot token
  as a secret (environment variable / Key), never in exported configuration.
