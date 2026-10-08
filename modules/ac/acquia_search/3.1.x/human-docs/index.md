# Acquia Search — manual setup guide

**Acquia Search** (`acquia_search`) connects your Drupal site to Acquia's hosted,
managed Apache Solr search service. It is an integration layer rather than a
search engine of its own: it rides on top of the **Search API Solr** module and
supplies a pre-configured Solr server whose connection is authenticated with your
Acquia subscription credentials. Once your site is connected to an Acquia
subscription, indexing and querying "just work" against the correct hosted Solr
core — you never have to hand-write Solr connection details or store raw Solr
credentials.

Under the hood the module adds a Solr **connector** (`solr_acquia_connector`) and a
Search API **backend** (`acquia_search_solr`) that sign every request to Acquia's
Solr endpoints using HMAC credentials derived from the **Acquia Connector**
subscription (identifier, secret key, and application UUID). It ships a ready-made
Search API server (`acquia_search_server`) and a settings object so the plumbing
is already in place. Because each Acquia environment (production, dev, test) maps
to specific Solr cores, the module discovers the cores available to your
subscription and automatically picks the right one for the current environment.

To protect shared cores, Acquia Search enforces a **read-only** mode on
non-production or ambiguous environments, so a staging copy can never overwrite
production's search index. You can also pin a specific core by hand, tune
per-index query behaviour, and inspect cores with the module's Drush commands. A
live index needs network access to Acquia and a valid subscription — on a
disconnected or local site the module installs and configures but cannot actually
reach Solr.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the Drush commands and
service internals — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, note the
   dependencies, and enable the module.
2. [Configuration](configuration/index.md) — connecting the subscription, the
   default Search API server, read-only mode, pinning a core, and the settings
   keys.

## Where it lives in the admin menu

Acquia Search has **no admin page of its own**. You operate it through the Search
API interface at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), where its server appears, plus a small config
object edited via Drush. Your subscription itself is connected through the
**Acquia Connector** module's settings.

## How to use it

1. Connect the site to your Acquia subscription with Acquia Connector.
2. Enable Acquia Search — a Search API server (*Acquia Search*) is created for you.
3. Attach a Search API index to that server and add the fields/content you want
   searchable, exactly as with any Search API setup.
4. Index your content and point your search page or Views search at the index. See
   [Configuration](configuration/index.md) for read-only mode and core selection.
