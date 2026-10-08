# LocalGov Irish Service Catalogue — manual setup guide

**LocalGov Irish Service Catalogue** (`localgov_irish_service_catalogue`) scaffolds
everything an Irish council needs to publish a searchable **catalogue of its
services**. When enabled it sets up the content types, Views-based listings, faceted
search, and content migrations that together let editors build and maintain a
structured service directory — the kind of "find a council service" section common on
local-government sites.

It builds on several well-known Drupal modules: **Search API** and **Facets** power
the searchable, filterable listings, and **Migrate Plus** supports importing content.
The module also defines its own permissions to control who can work with the catalogue.

This is a content-model and site-building feature, part of the **LocalGov Drupal**
distribution. It expects to run on a LocalGov Drupal site and, beyond its own
permission, does not itself act as an access-control layer — the catalogue entries are
ordinary content following normal access rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pull in its Search API / Facets / Migrate dependencies.

There is **no single settings page** for this module — it works by installing content
types, Views, facets and migrations that you then use through the standard content and
search UIs, described under "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated settings page of its own (`configure` is `null`). You
work with what it scaffolds through several existing admin areas:

- **Content → Add content** (`/node/add`) — the service-catalogue content types.
- **Configuration → Search and metadata → Search API**
  (`/admin/config/search/search-api`) — the search index that powers the catalogue.
- **Structure → Views** — the catalogue listing pages.
- **People → Permissions** (`/admin/people/permissions`) — the module's own
  permissions.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Under **People → Permissions**, grant the module's permissions to the roles that
   will build and manage the catalogue.
3. Create service entries via **Content → Add content**, using the content types the
   module provides.
4. Make sure the **Search API** index is set up and indexed (Configuration → Search
   and metadata → Search API) so the catalogue's faceted search and listings return
   results.
5. If you are migrating an existing catalogue, use the Migrate Plus-based migrations
   the module ships to import your content.
