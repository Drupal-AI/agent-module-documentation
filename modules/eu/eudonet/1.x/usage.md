<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Eudonet provides a developer-facing PHP client — the `eudonet` Drupal service — for building and executing typed requests (authenticate, catalog, meta-infos, search, attachments, create/update/delete) against the Eudonet CRM REST API and reading back wrapped responses.

---

The module exposes a single service, `eudonet` (class `Drupal\eudonet\Eudonet`), whose shorthand methods each return an **EudonetQuery** plugin: `authenticate()`/`getAuthenticationQuery()`, `catalog($descId)`, `metaInfos($tableList)`, `search($additionalPath)`, `attachment(...)`, and `cud()`/`cudCreate()`/`cudUpdate()`/`cudUpdateImage()`/`cudDelete()`. Each query plugin carries an annotation (`path`, `method`, `authentication`, `query_result`); calling `->execute()` on it sends a Guzzle request (built with `http_client_factory->fromOptions()`, `base_uri` from config) and returns a matching **EudonetQueryResult** plugin that decodes the JSON body and exposes helpers such as `success()`, `getErrorNumber()`, `getErrorMessage()`, quota headers, and result iteration. Search queries are assembled fluently with `addFields()`, `condition()`, `orGroup()`/`andGroup()`/`conditionGroup()`, paging and order-by traits; the operator and inter-operator maps live as constants on `Eudonet`. A third plugin type, **eudonet_mapping** (discovered from `*.eudonet.mapping.yml`, e.g. the shipped `eudonet.eudonet.mapping.yml` `default` map), lets code reference CRM columns by human field names instead of numeric DescIds. Connection settings — API `base_url`, the seven `authentication` parameters (subscriber login/password, base name, user login/password, language, product name) and the cached `token_info` (token, expiration, server date) — are held in the `eudonet.eudonetconfig` config object and edited at `/admin/config/services/eudonet` (route `eudonet.eudonet_config_form`, admin route). On an authenticated query the base class auto-refreshes the token when it is missing or within two hours of expiry, then sends it as the `x-auth` request header. The module ships no content entities, fields, blocks, permissions, Drush commands, or public-facing data routes — it is an integration foundation meant to be driven from custom code.

---

- Authenticate a Drupal site against the Eudonet CRM API and cache the returned session token.
- Configure the Eudonet API base URL and login credentials from the admin UI.
- Test connectivity with the "Try auth request" button on the settings form.
- Search a CRM table for records matching field criteria and iterate the results.
- Build complex CRM searches with AND/OR condition groups and operators (`=`, `^`, `IN`, `NOT EMPTY`, etc.).
- Select specific columns to return from a search with `addFields()`.
- Page through large CRM result sets and apply order-by clauses.
- Read a catalog (drop-down/reference list) by its DescId, or the `Users` catalog.
- Retrieve table/field metadata (`metaInfos`) for one table, several, or the whole base.
- Create a new CRM record in a table (`cudCreate($tabId)` + `setValues()`).
- Update fields on an existing CRM record (`cudUpdate($tabId, $fileId)`).
- Delete a CRM record (`cudDelete($tabId, $fileId)`).
- Update the image/photo attached to a CRM record (`cudUpdateImage()` + `setImageValue()`).
- Attach a base64-encoded file (or a URL) to a CRM record (`attachment()`).
- Prepare an uploaded file for the CRM with `Eudonet::prepareFileForUpload()` (base64).
- Map human field names to Eudonet numeric DescIds via a custom `*.eudonet.mapping.yml` plugin.
- Reference the shipped `default` mapping (last_name, first_name, gender, birth_date, birth_place).
- Clean CRM-returned strings (decode HTML entities, XSS-filter) with `Eudonet::cleanString()`.
- Read remaining API call quotas from response headers (`getRemainingCalls()`, `isExceedQuotas()`).
- Detect and handle CRM token-expiry errors and re-authenticate automatically.
- Extend the client with a new EudonetQuery/EudonetQueryResult plugin pair for another endpoint.
- Alter existing query plugin definitions via the `eudonet_eudonet_query_info` alter hook.
- Drive CRM synchronisation jobs (import/export of contacts) from a custom module or cron task.
