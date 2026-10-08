# Crowdriff API — manual setup guide

**Crowdriff API** (`crowdriff_api`) provides the base integration with the
**CrowdRiff v2** visual content / user-generated-media platform. CrowdRiff is a
service for sourcing and managing visual and UGC media (photos and videos, organized
into folders, albums, apps, and galleries), and this module gives your Drupal site a
client and admin configuration for talking to its API — fetching folders, albums,
apps, CTAs, and assets, including paged search.

An important expectation to set: this is a **foundation module, not a ready-made
gallery**. It provides the connection and a service class other code can call, but
it doesn't output anything on its own — you (or another module) build on top of it.
The most common companion is
[Media Library Crowdriff](https://www.drupal.org/project/media_library_extend_crowdriff),
which uses this module to pull CrowdRiff assets into Drupal's Media Library as media
entities.

The module reads the CrowdRiff API through a service (`CrowdriffService`) using a
Bearer token, caches responses in a dedicated cache bin with a configurable
lifetime, and falls back to stale cache if the API is unavailable. The API token is
stored securely as a **Key** entity (not plain config) and read at request time, and
outbound calls use secure TLS with sensible timeouts. Access to the settings is
gated by the **administer crowdriff** permission.

It depends on the **Key** module (`key`) and requires a **CrowdRiff API key** to do
anything. It supports Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Key dependency.
2. [Configuration](configuration/index.md) — store the API key as a Key, then select
   it and set the API and caching options.

## Where it lives in the admin menu

The settings are at **Configuration → Web services → Crowdriff**
(`/admin/config/services/crowdriff`), behind the **administer crowdriff**
permission.
