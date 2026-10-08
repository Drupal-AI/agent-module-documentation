# Immich Integration — manual setup guide

**Immich Integration** (`immich_integration`) connects Drupal to a self‑hosted
[Immich](https://immich.app/) photo‑ and video‑management server. Immich is an
open‑source alternative to cloud photo services, with automatic mobile backup,
face recognition, powerful search, timeline views, albums, and shared links.
This module gives Drupal a clean, reusable way to talk to that server's REST API.

The heart of the module is a service called `immich_integration.client` — an
injectable `ImmichClient` that wraps more than fifty Immich API methods: server
health and stats, album CRUD, asset listing and metadata, search, timeline
buckets, people/faces, tags, shared links, users, libraries, and memories. Rather
than shipping opinionated front‑end features, the module gives developers this
service layer to build exactly the Immich integration they need — a gallery, a
media‑library importer, a custom search interface, and so on. A couple of demo
admin pages (an album list and a simple gallery) ship as reference examples.

For a site builder, the part you configure by hand is small: a settings form where
you enter your Immich **server URL** and **API key**, with an AJAX "Test
Connection" button to confirm it works. The module uses Drupal's default HTTP
client, so TLS certificate verification is on — see
[Configuration](configuration/index.md) for how to keep the API key out of
committed config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter and test your Immich server
   URL and API key, and store the key safely.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Media → Immich**
(`/admin/config/media/immich`). The module also adds admin‑only album list and
album view pages nearby. Every route requires the **Administer site configuration**
permission.

## How to use it

For content editors there is nothing to click beyond the demo album pages. The
module is really aimed at developers: after configuring the connection, inject the
`immich_integration.client` service into your own module, controller, block, or
plugin and call its methods (each returns the decoded response array, or `NULL`
on failure, logging the error). See the sibling [`agent/`](../agent/start.md) docs
for the full method list.
