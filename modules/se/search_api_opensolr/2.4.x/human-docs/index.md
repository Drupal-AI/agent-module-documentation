# Search API opensolr — manual setup guide

**Search API opensolr** (`search_api_opensolr`) lets you use the hosted
[opensolr.com](https://opensolr.com) service as the Solr search backend for your
Drupal site — so you get a Solr-powered search without installing or operating a
Solr server yourself. It builds on **Search API Solr**, adding Solr connector
plugins and admin tooling that connect Drupal to your opensolr account.

The convenience is that it fills in the fiddly connection details for you. Once
you've entered your opensolr email and API key, the module can auto-create a Solr
core and a matching Search API server in one step ("Autoconfigure") and upload the
Solr configuration to opensolr — all without leaving the admin UI. A **Get
started** page walks you through the four steps and shows which ones you've already
completed. It provides two connector plugins: **Opensolr** and the recommended
**Opensolr with Basic Auth**, both of which pre-fill the connection and
authentication settings from your account so the only real choice you make is which
core to use.

Your opensolr credentials are best kept out of plain configuration. If the
optional **Key** module is installed you can opt in to storing the API key as a Key
entity (which can draw the value from an environment variable or file); otherwise
it's stored as a raw config value. A bundled submodule,
**search_api_opensolr_security**, manages per-core HTTP Basic Auth credentials and
IP allow-lists on opensolr.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally Key), and pick the security submodule if needed.
2. [Configuration](configuration/index.md) — entering your opensolr credentials,
   the setup flows (Get started, Autoconfigure, add a server), and the connectors.

## Where it lives in the admin menu

The credentials/settings form is at **Configuration → Search and metadata →
Search API → Opensolr** (`/admin/config/search/search-api/opensolr`), gated by the
*administer search_api_opensolr* permission. Servers themselves are created under
Search API (**Add server**), and each opensolr-backed server gains an **Opensolr**
tab for uploading configuration.

## How to use it

1. Create an opensolr account at [opensolr.com/register](https://opensolr.com/register)
   and note its email and API key. (Account creation happens on opensolr.com; the
   **Get started** page links you there and tracks your progress.)
2. Enter those on the Opensolr settings form and use **Test connection** to check
   them.
3. Either run **Autoconfigure** to create a core and Search API server in one go,
   or add a Search API server manually with the **Opensolr with Basic Auth
   (recommended)** connector and pick a core from the dropdown.
4. Add your index to that server and index your content as usual with Search API.

See [Configuration](configuration/index.md) for the full walkthrough.
