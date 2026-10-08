# Immoweb API Client — manual setup guide

**Immoweb API Client** (`immoweb_api_client`) is an integration layer between the
[Immoweb](https://www.immoweb.be/) API and Drupal. Immoweb is a Belgian
real‑estate platform, and this module gives your site a ready‑made client for
talking to its API: it handles OAuth customer authentication (including automatic
token refresh) and exposes the "classified pipeline" endpoints as Drupal services,
so other modules can create, update, and fetch property listings — Immoweb calls
each listing a *classified* — without re‑implementing the plumbing.

This is a **developer‑oriented** module. On its own it provides no visible
feature: no blocks, no content types, no editor screens. What it gives you is a
configuration form for your Immoweb credentials plus a set of injectable services
your own custom code calls. Version 3.0.x integrates with version 3 of the Immoweb
API, which the maintainer recommends as the future‑proof choice.

Before you can use it you must **request API credentials from Immoweb** for your
specific project — contact the Immoweb team at `api@immoweb.be`. Those credentials
are secrets: store them in an environment variable, never commit them, and give
them the same care you would any production API key (see
[Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Immoweb API credentials
   and store them safely.

## Where it lives in the admin menu

Once enabled, the module provides a configuration form for your Immoweb API
credentials under **Configuration** (in the module's own settings page). It also
defines its own permission for administering that configuration. The real work
happens in code: inject the module's client/pipeline services into your custom
module to authenticate and call the classified endpoints.

## How to use it

1. Obtain project‑specific API credentials from Immoweb (`api@immoweb.be`).
2. Install and enable the module, then enter the credentials on its settings form.
3. In your own module, inject the provided services. Authentication and token
   refresh are handled for you — you can call the classified pipeline services
   directly, and the module validates required values against the schema when you
   create or update a classified.

Because newer Immoweb API versions can occasionally break the integration layer
(not every endpoint is version‑locked), watch the project's issue queue and report
problems if an endpoint changes upstream.
