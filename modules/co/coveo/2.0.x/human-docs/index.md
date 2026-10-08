# Coveo — manual setup guide

**Coveo** (`coveo`) connects your Drupal site to the **Coveo** hosted search
platform. Instead of searching a local index, your content is pushed up to Coveo's
cloud service, and search experiences on your site are rendered against that hosted
index. It is aimed at sites that want Coveo's search relevance, machine-learning
ranking and rich search UIs rather than a self-hosted search backend.

Version 2 is a large refactor built around Coveo's JavaScript search frameworks. Its
capabilities are split across three submodules, so you enable only the pieces you
need:

- **Coveo Search API** (`coveo_search_api`) — a Search API backend that pushes your
  content (and user identities) up to a Coveo organization/index.
- **Coveo Atomic** (`coveo_atomic`) — development tools and a block for building
  search experiences with Coveo's **Atomic** web-component UI framework.
- **Coveo Secured Search** (`coveo_secured_search`) — a security-provider integration
  that issues **search tokens** so access-restricted content isn't exposed to users
  who shouldn't see it.

An important point about data handling: your content is **indexed in an external
service**, and a hosted index is **not** automatically governed by Drupal's own
entity-access rules. If any of your content is access-restricted, you must enable
**Coveo Secured Search** and configure token-based access — otherwise the hosted index
can surface content to users Drupal would have blocked. The module also talks to Coveo
over the network using **API credentials**, which must be stored as secrets (see
[Configuration](configuration/index.md)). Note that this project describes itself as
under active development and not yet production-ready — plan a careful evaluation
before relying on it for a live site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — connect to your Coveo organization,
   store the API credentials securely, index content, and (if needed) turn on secured
   search.

## Where it lives in the admin menu

The base module adds no single settings page of its own; configuration lives with the
submodules — Coveo Search API appears under Drupal's **Search API** administration
(**Configuration → Search and metadata → Search API**), and the Atomic tools/block
are placed like any other block. See [Configuration](configuration/index.md) for the
details.
