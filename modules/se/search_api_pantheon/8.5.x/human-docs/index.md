# Search API Pantheon — manual setup guide

**Search API Pantheon** (`search_api_pantheon`) wires Search API and Search API Solr
to the Apache Solr add-on that [Pantheon](https://pantheon.io/) provisions for each
of your site's environments. Its whole point is that you never enter Solr connection
details by hand: the module reads the host, port, scheme, path, and core from
Pantheon's environment variables at runtime, so a single exported configuration works
unchanged across Dev, Test, Live, and Multidev — each of which has its own isolated
Solr core.

When you enable the module it installs a ready-to-use **Pantheon Search** server and
a **Primary** index, so you have a working starting point immediately. From there you
use all the normal Search API workflows — add fields to the index, post the Solr
schema, index your content, and build search pages, facets, and autocomplete on top.
A toolkit of Drush commands handles the Solr-specific chores: posting the schema
(and automatically reloading the core so it does not silently revert), running health
checks, executing ad-hoc queries, and cleaning up the core if it becomes corrupted.

> **This module only works on Pantheon.** It relies on Pantheon's environment
> variables (gated by `PANTHEON_ENVIRONMENT`), so off Pantheon it is a no-op. You
> must enable Solr as a Pantheon add-on and set the Solr version in `pantheon.yml`
> before it will do anything.

This guide is written for a **human** clicking through the admin UI and terminal. If
you want terse, token-cheap references for an AI coding agent — including the
connector internals and every Drush flag — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Pantheon prerequisites, installing
   with Composer, and enabling the module.

## Where it lives in the admin menu

Search API Pantheon has **no settings page of its own**. It creates Search API config
entities that you manage through Search API's own UI at **Configuration → Search and
metadata → Search API** (`/admin/config/search/search-api`). The Solr-specific
operations are done from the command line with the module's Drush commands.

## How to use it

Once the Pantheon prerequisites are in place (see
[Installation](installation/index.md)) and the module is enabled:

1. Go to **Configuration → Search and metadata → Search API**. The **Pantheon
   Search** server and **Primary** index are already there.
2. On the Primary index's **Fields** tab, add the fields you want searchable (for
   example Title and Body) and save.
3. Post the Solr schema so Solr understands those fields:

   ```bash
   drush search-api-pantheon:postSchema
   ```

   This uploads the config-set for your installed Search API Solr / Solr version and
   automatically reloads the core.
4. Index your content (use **Index now** on the index, or wait for cron).
5. Build a View of type "Index" with an exposed keywords filter and a relevance sort
   to create a search page. Layer on facets or autocomplete from Search API Solr as
   needed.
6. Export your configuration (`drush config:export`) so the server and index YAML are
   version-controlled and deploy cleanly to Test and Live.

> **Re-post the schema** after any change that affects Solr fields — adding new field
> types, upgrading Search API Solr, switching between Solr 8 and 9, or enabling Search
> API Solr submodules.

### Handy Drush commands

| Command | Alias | Purpose |
|---|---|---|
| `search-api-pantheon:postSchema [path]` | `sapps` | Post the Solr schema (optionally a jump-start or custom config-set) and reload the core. |
| `search-api-pantheon:reloadSchema` | — | Manually reload the Solr core. |
| `search-api-pantheon:diagnose` | `sapd` | End-to-end health check of the Search API / Solr setup. |
| `search-api-pantheon:ping` | `sapp` | Confirm the Solr host is reachable. |
| `search-api-pantheon:select <query>` | `saps` | Run a raw Solr query for debugging. |
| `search-api-pantheon:test-index-and-query` | `sap-tiq` | Smoke test: index one item and query it back. |
| `search-api-pantheon:view-schema <file>` | `sapvs` | Print a schema file currently on the server. |
| `search-api-pantheon:force-cleanup` | `sapfc` | Wipe the Solr core to recover from corruption. |

On Pantheon, run these through Terminus, e.g.
`terminus drush <site>.<env> -- search-api-pantheon:postSchema`.
