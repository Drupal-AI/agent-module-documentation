# Jellyfin Integration — manual setup guide

**Jellyfin Integration** (`jellyfin_integration`) connects your Drupal site to a
[Jellyfin](https://jellyfin.org) media server. It gives you two things: a reusable
**client service** that wraps Jellyfin's REST API for developers, and an
**admin‑only browsing UI** where you can connect to your server and page through
its libraries, movies, TV series, and individual items — complete with posters,
backdrops, and metadata.

The client service (`jellyfin_integration.client`) covers a broad slice of the
Jellyfin API — system and server info, libraries and media folders, item queries
with filters, "latest" / "resume" / "similar" lists, search, genres, studios,
artists and persons, plus helpers that build poster, backdrop, and direct stream
URLs. Custom code can inject that service and reuse it. The built‑in admin pages
let you browse everything visually without writing any code.

Connecting requires your Jellyfin **server URL** and an **API key** generated on
the Jellyfin side. Every feature — both the settings form and the browsing pages —
is gated behind the **Administer site configuration** permission, so the whole
integration is administrators‑only; there are no anonymous or public endpoints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Jellyfin server URL and
   API key, and test the connection.

## Where it lives in the admin menu

The settings and browsing pages live under **Configuration → Media → Jellyfin
Integration** (`/admin/config/media/jellyfin`), with sub‑pages for libraries,
movies, series, per‑library items, and item detail. All of them require the
**Administer site configuration** permission.
