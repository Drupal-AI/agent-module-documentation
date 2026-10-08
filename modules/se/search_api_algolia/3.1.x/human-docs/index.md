# Algolia Search — manual setup guide

**Algolia Search** (`search_api_algolia`) is a **Search API backend** that indexes
your Drupal content into the hosted **Algolia** search engine. It handles the
indexing side only: Drupal pushes your content up to Algolia, and you build the
actual search UI on the front end with Algolia's JavaScript API. It's a good fit
when you want Algolia's fast, typo‑tolerant, hosted search but still want Drupal to
own what gets indexed.

The way it works within Search API: you create a Search API **server** using the
"Algolia" backend and give it your Algolia **Application ID** and **Write API Key**,
then create one or more **indexes** pointed at Algolia index names. Each index gets
some extra Algolia‑specific options — such as a language suffix for multilingual
sites, batched deletion, a custom `objectID` field, and partial updates. A processor
can split oversized items into multiple Algolia records to stay under Algolia's
per‑record size limit.

Because it plugs into Search API, this module has **no configuration page of its
own** — you configure a Search API server and index. It requires the **Search API**
module and the `algolia/algoliasearch-client-php` (v4) PHP library (pulled in by
Composer), plus an Algolia account. It provides a Drush command for flushing queued
deletions, and integrates optionally with **Search API Autocomplete** (via Algolia
Query Suggestions). It ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and get your Algolia credentials.
2. [Configuration](configuration/index.md) — add the Algolia server, point an index
   at Algolia, set the per‑index options, and tune the module settings.

## Where it lives in the admin menu

Everything is configured through **Search API**, under **Configuration → Search and
metadata → Search API** (`/admin/config/search/search-api`) — you add a server with
the Algolia backend and edit your indexes there. The module also stores a small
settings object (`search_api_algolia.settings`) adjusted via Drush.

## How to use it

At a high level: create an Algolia account and get your Application ID and Write API
Key, add a Search API server using the Algolia backend with those credentials,
create an index that uses that server and point it at an Algolia index name, then add
your content and fields and index them. The search front end itself is built
separately with Algolia's JavaScript libraries. See
[Configuration](configuration/index.md) for the walkthrough.
