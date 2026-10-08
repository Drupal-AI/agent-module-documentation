<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the SearchStax connector

There is **no dedicated settings page** for this module. It is configured as the connector of a
Search API Solr server.

## Steps
1. Enable `search_api`, `search_api_solr`, and `search_api_searchstax`.
2. Add a Search API server (`/admin/config/search/search-api/add-server`), backend **Solr**.
3. For the Solr Connector choose **"SearchStax Cloud with Token Auth"** (id `searchstax`).
4. Fill the two connector fields (from the SearchStax app/index dashboard):
   - **Endpoint** (`update_endpoint`) — the SearchStax "Update endpoint" URL.
   - **Read & write token key** (`update_token`) — the SearchStax "Read & Write token key".
5. Create a Search API index against this server and configure fields as usual.
6. Generate/upload the Solr config-set as prompted by `search_api_solr` (the connector produces it
   locally — see `agent/api/connector-internals.md`), then index.

## What the form does with those two fields
- Host/port/path/core/context fields that `StandardSolrConnector` normally shows are converted to
  hidden `#type: value` fields; you do **not** enter them.
- `scheme` is forced to `https`, `port` to `443`, `path` to `/`.
- `validateConfigurationForm()` trims both values and regex-parses the endpoint against
  `@https://([^/:]+)/([^/]+)/([^/]+)/(update|select)$@`, setting `host`, `context`, and `core`
  from the three captured groups. A non-matching endpoint yields "Invalid endpoint format"; an
  empty token yields "Invalid token format".

## Where the token is stored
- Both values are persisted in the Solr **server config entity** under the connector configuration
  keys `update_endpoint` and `update_token` (config schema
  `plugin.plugin_configuration.search_api_solr_connector.searchstax`), as plaintext strings.
- Because Search API server config is exportable, treat `update_token` as a secret: keep it in an
  environment variable and inject it (e.g. via a Key / config override) rather than committing the
  value. This repo's convention is `ddev dotenv set .ddev/.env --…` plus a Key entity or a
  `settings.php` `$config` override.

## Runtime auth
Every connection sets an HTTP `Authorization: Token <update_token>` header on the Solr endpoint
(`connect()` → Solarium `setAuthorizationToken('Token', …)`). Nothing else is sent to authenticate.
