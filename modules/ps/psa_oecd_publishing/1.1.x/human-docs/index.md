# OECD GlobalRecalls API — manual setup guide

**OECD GlobalRecalls API** (`psa_oecd_publishing`) connects your Drupal site to the
OECD GlobalRecalls portal. If you hold product‑recall notices as nodes on your site,
this module lets you publish them to the OECD GlobalRecalls portal through its import
API, and lets editors search for and delete recalls on that portal by ID.

You configure an API key, choose the production or testing host, and map the fields on
your recall nodes to the fields the OECD portal expects. Publishing a recall packages
the node as a ZIP archive and uploads it to the portal's import endpoint; the work is
queued, so it can run in the background on cron, and Drush commands are provided for
headless or scheduled publishing runs.

The module talks to the portal over HTTPS, and the API key travels only over TLS. All
of its editor‑facing screens are gated by permissions — there are no anonymous or
unauthenticated endpoints. Note that the API key is stored in module configuration, so
protect and key your configuration according to your own security policy.

> This module has **not** been developed by the OECD. The OECD neither endorses nor
> requires its use, and provides no warranty or indemnity for it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter the API key, choose the host, map
   your fields, and assign the permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → OECD GlobalRecalls API**
(`/admin/config/services/psa-oecd-publishing`). The editor tools — a "publish needed"
list, a search‑by‑ID form, and a confirm‑delete form — sit under the same path. See
[Configuration](configuration/index.md).
