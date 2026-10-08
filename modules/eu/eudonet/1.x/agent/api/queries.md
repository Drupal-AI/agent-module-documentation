<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query & query-result plugin types

The module defines two plugin types plus their managers (`eudonet.services.yml`):

- **eudonet_query** — one HTTP request to the API. Manager
  `Drupal\eudonet\Plugin\EudonetQueryManager` (dir `Plugin/EudonetQuery`, interface
  `EudonetQueryInterface`, annotation `Drupal\eudonet\Annotation\EudonetQuery`, alter hook
  `eudonet_eudonet_query_info`). Base `EudonetQueryBase`.
- **eudonet_query_result** — wraps/decodes the response. Manager
  `EudonetQueryResultManager` (dir `Plugin/EudonetQueryResult`, annotation
  `EudonetQueryResult`). Base `EudonetQueryResultBase`.

## `@EudonetQuery` annotation keys

`id`, `label`, `path` (resource base path appended to `base_url`), `method` (default HTTP verb),
`authentication` (bool — send `x-auth` token), `query_result` (result plugin id, default
`eudonet_default_query_result`).

## Shipped query plugins (`src/Plugin/EudonetQuery/`)

| Plugin id | Class | path | method | auth | result plugin |
|---|---|---|---|---|---|
| `eudonet_authentication_query` | AuthenticationQuery | `Authenticate/Token` | POST | no | `eudonet_authentication_query_result` |
| `eudonet_catalog_query` | CatalogQuery | `Catalog/` + descId/`Users` | GET (POST for `Users`) | yes | `eudonet_catalog_query_result` |
| `eudonet_meta_infos_query` | MetaInfosQuery | `MetaInfos/` (+`ListTabs/`) | POST (GET for table-list) | yes | `eudonet_meta_infos_query_result` |
| `eudonet_search_query` | SearchQuery | `Search/` + additionalPath | GET (POST for single-segment, `Fast`, `PlanningOccupied`) | yes | `eudonet_search_query_result` |
| `eudonet_attachments_query` | AttachmentsQuery | `Annexes/Add` | POST | yes | *(default)* |
| `eudonet_cud_query` | CUDQuery | `CUD/` + additionalPath | POST (DELETE when path starts `Delete`) | yes | *(default)* |

- `AuthenticationQuery::build()` returns `configuration['authentication_parameters']`.
- `CatalogQuery`/`SearchQuery` throw an `Exception` in the constructor when `additional_path` is
  missing. `getPath()` appends `additional_path` to the annotation `path`; `getMethod()` picks
  GET/POST per rules above.
- `MetaInfosQuery::build()` maps table ids to `{DescId, AllFields:TRUE, Fields:[0]}`.
- `CUDQuery`: `setValue($fieldName,$value)` / `setValues([...])` push `{DescId,Value}` entries
  (field name resolved through the active mapping); `setImageValue()` sets a single image payload.

## SearchQuery fluent builder (traits)

`SearchQuery` composes four traits:

- **EudonetQueryFieldTrait**: `addField($name)` / `addFields([...])` → `ListCols` (names resolved
  through the mapping to DescIds).
- **EudonetQueryConditionTrait**: `condition($field, $value, $operator='=')`,
  `conditionGroup(EudonetQueryCondition)`, `orGroup()`, `andGroup()`, `group($interOperator)`.
  Conditions build a `WhereCustom` tree; each `EudonetQueryCondition::build()` emits
  `{WhereCustoms, Criteria:{Operator,Field,Value}, InterOperator}` using the `OPERATORS` /
  `INTER_OPERATORS` maps.
- **EudonetQueryPagerTrait**: `pager($length=0, $offset=0)` → `{RowsPerPage, NumPage}`.
- **EudonetQueryOrderByTrait**: `orderBy($field, $order=0)` → `OrderBy[]{DescId,Order}`.

`SearchQuery::build()` returns `{ShowMetaData:TRUE, ListCols, WhereCustom}` merged with pager and
order-by.

## Result plugins (`src/Plugin/EudonetQueryResult/`)

`EudonetQueryResultBase` JSON-decodes the Guzzle body and exposes: `success()`
(`ResultInfos.Success`), `getApiMessage()`, `getErrorMessage()`, `getErrorNumber()`,
`getResponse()`, `getGuzzleResponse()`, quota getters `getMaxAllowedRequests()`
(`X-CALL-MAX`), `getRemainingCallsByIp()` (`X-CALL-BYIP-REMAIN`), `getRemainingCalls()`
(`X-CALL-REMAIN`), `isExceedQuotas()`, and `ensureAuth()` (re-authenticates once when
`getErrorNumber()` is in `Eudonet::TOKEN_ERRORS`).

- `AuthenticationQueryResult` — persists `token_info` to config; `getToken()`.
- `SearchQueryResult` — `Iterator` + `Countable`; wraps each `ResultData.Rows` item in
  `EudonetSearchQueryResultItemWrapper`; `getItems()`, `label()`, plus paging via
  `EudonetQueryResultPagerTrait` (`getCurrentPage()`, `getTotalPages()`, `getTotalRows()`,
  `getNextPage()`, `hasNextPage()`).
- `CatalogQueryResult`, `MetaInfosQueryResult`, `AttachmentsQueryResult`, `DefaultQueryResult` —
  typed accessors over the decoded response.

## Result item wrapper

`EudonetSearchQueryResultItemWrapper` (`src/EudonetSearchQueryResultItemWrapper.php`): `id()` →
`FileId`; magic `__get($name)` resolves `$name` (mapped → DescId) by recursively walking the row
tree (`getDescIdPath()` / `getDescIdItem()`) and returns the matching cell object (with `Value`),
or NULL. Uses the mapping selected at construction (default `default`).

## Extending

Add a new endpoint by shipping a query plugin (annotated `@EudonetQuery`) extending
`EudonetQueryBase` and, optionally, a matching `@EudonetQueryResult` plugin. Existing definitions
can be modified with `hook_eudonet_eudonet_query_info_alter()`.
