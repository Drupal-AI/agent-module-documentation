<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eudonet (eudonet) — agent index

A developer-facing **PHP client for the Eudonet CRM REST API**, exposed as the Drupal service
**`eudonet`** (`Drupal\eudonet\Eudonet`). Requests are modelled as **EudonetQuery** plugins and
responses as **EudonetQueryResult** plugins; a **eudonet_mapping** plugin type maps human field
names to numeric CRM DescIds. Package `Eudonet`. Core `^10.1 || ^11`. License GPL-2.0-or-later.
Version `1.x` (dev checkout, no `version:` in info.yml). **No** module dependencies, entities,
fields, permissions, Drush, or public data routes.

## Solution docs

- **The `eudonet` service + shorthand methods, request/response flow, token handling** →
  [api/client.md](api/client.md)
- **The query & query-result plugin types, every shipped plugin, conditions/fields/paging** →
  [api/queries.md](api/queries.md)
- **Settings form, config object & schema, how to configure/operate it** →
  [config/settings.md](config/settings.md)
- **Field mapping (`eudonet_mapping`) — `*.eudonet.mapping.yml` plugins** →
  [plugins/mapping.md](plugins/mapping.md)

## What it actually is (from source)

- **Service** `eudonet` → `src/Eudonet.php`, args `@plugin.manager.eudonet_query`,
  `@config.factory`. Shorthands: `authenticate()`, `getAuthenticationQuery(...)`,
  `catalog($descId)`, `metaInfos($tableList=TRUE)`, `search($additionalPath)`,
  `attachment($fileId,$tabId,$filename,$content,$isUrl=FALSE)`, `cud()/cudCreate()/cudUpdate()/`
  `cudUpdateImage()/cudDelete()`. Static helpers `trim()`, `cleanString()` (Xss::filter +
  entity decode), `prepareFileForUpload()` (base64). Constants `OPERATORS`, `INTER_OPERATORS`,
  `TOKEN_ERRORS`, `EUDONET_CONFIG = 'eudonet.eudonetconfig'`.
- **3 plugin managers** (`eudonet.services.yml`): `plugin.manager.eudonet_query`,
  `plugin.manager.eudonet_query_result` (both `parent: default_plugin_manager`),
  `plugin.manager.eudonet_mapping` (custom, YAML discovery).
- **Query plugins** in `src/Plugin/EudonetQuery/` (annotation `@EudonetQuery`, base
  `EudonetQueryBase`): `AuthenticationQuery` (`Authenticate/Token`, POST, no-auth),
  `CatalogQuery` (`Catalog/`, GET), `MetaInfosQuery` (`MetaInfos/`, POST), `SearchQuery`
  (`Search/`, GET/POST), `AttachmentsQuery` (`Annexes/Add`, POST), `CUDQuery` (`CUD/`,
  POST/DELETE). All except Authentication have `authentication = TRUE`.
- **Result plugins** in `src/Plugin/EudonetQueryResult/` (base `EudonetQueryResultBase`):
  `AuthenticationQueryResult` (stores token to config), `CatalogQueryResult`,
  `MetaInfosQueryResult`, `SearchQueryResult` (Iterator/Countable of
  `EudonetSearchQueryResultItemWrapper`), `AttachmentsQueryResult`, `DefaultQueryResult`.
- **Config**: single config object `eudonet.eudonetconfig` (schema
  `config/schema/eudonet.eudonetconfig.schema.yml`, empty install default). Admin form
  `EudonetConfigForm` at `/admin/config/services/eudonet`
  (route `eudonet.eudonet_config_form`, admin route, menu link
  under *Configuration → Services*).
- **Hook**: only `eudonet_help()` in `eudonet.module`. Plugin-def alter hook available:
  `eudonet_eudonet_query_info`.

## Mechanism (from `EudonetQueryBase::execute()`)

- Reads `base_url` from `eudonet.eudonetconfig`; builds a Guzzle client with
  `http_client_factory->fromOptions(['base_uri' => $base_url, ...])`. POST requests send the
  built body as `json` with `timeout => 0`.
- If the plugin needs auth: reads cached `token_info`; if the token is empty or its `expiration`
  is within `+2 hours`, calls `eudonet->authenticate()` to refresh it; sends the token as the
  **`x-auth`** header. Missing token → error message + `logger('eudonet')->error()`.
- The response is handed to the plugin's `query_result` plugin, which JSON-decodes the body and
  exposes `success()`, `getErrorNumber()`, `getErrorMessage()`, `getApiMessage()`, quota getters
  (`getRemainingCalls()`, `isExceedQuotas()` from `X-CALL-*` headers), and `ensureAuth()`
  (re-auth on `TOKEN_ERRORS`).
