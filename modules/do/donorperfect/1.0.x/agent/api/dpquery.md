<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DPQuery — the DonorPerfect XML API client

Service `donorperfect.dpquery` (`src/DPQuery.php`). A fluent query builder that compiles
SQL / DonorPerfect predefined procedures and sends them to the DonorPerfect XML API. Injected
with `donorperfect.dputility`, Guzzle `http_client`, `config.factory`, `current_user`.

## Endpoint and credentials

- Endpoint is a hardcoded HTTPS constant:
  `DPQuery::DONORPERFECT_API_URL = 'https://www.donorperfect.net/prod/xmlrequest.asp'`.
- Credentials are loaded in the constructor via `DPUtility::apiCredentialsLoad('dpquery')` and
  turned into an auth string: `apikey={key}` if an API key is set, otherwise
  `login={user}&pass={pw}`. If neither is present, `executeApiCall()` short-circuits with
  `resultCode = 403` and no request is made.
- By default `apiCredentialsLoad()` reads from the `donorperfect.settings` config object under
  `api.key` / `api.user` / `api.pw` (see [../config/settings.md](../config/settings.md)). A
  contributed module may replace this by implementing
  `hook_donorperfect_api_credentials_load_alter(&$credentials, $context)` (context is `dpquery`
  or `settings`); if the alter populates `$credentials`, config storage is skipped.
- Requests use Guzzle's default options (`['timeout' => 30]`); TLS verification is left at Guzzle's
  default. Configure per-call options with `setTimeout()` / `setHttpOption()`.

## Building a query

`create(string $type, mixed $optional = NULL, array $args = [])` returns a fresh DPQuery.
Valid `$type` values: `select`, `insert`, `update`, `pass`, `retrieveAllTableData`, plus the
predefined procedures `donorsearch`, `gifts`, `savedonor`, `savegift`, `saveotherinfo`,
`savecontact`, `delflags`, `saveflag`, `saveudf`.

- SELECT/INSERT/UPDATE: `$optional` is `base_table` or `base_table.base_field`; the base table
  must be one of the whitelisted `availTables` (`dp`, `dpudf`, `dpgift`, `dpgiftudf`, `dpaddress`,
  `dpaddressmailings`, `dplink`, `dpotherinfo`, `dpotherinfoudf`, `dppaymentmethod`, `dpcontact`,
  `dpcontactudf`, `dpusermultivalues`, `dpcodes`, `dpflags`, `dpbatch`), and fields must exist in
  the cached `availFields` (from `donorperfect.cache:dptables`) — unknown fields are silently
  dropped.
- `pass`: `$optional` is a raw SQL string; `$args` placeholders are substituted by
  `expandArguments()` (naive `preg_replace` of each placeholder token).

Chainable builders (return `$this`): `addField($field, $value = NULL, $add_quotes = FALSE)`
(alias `addParam()`), `removeField()`, `hasField()`, `addCondition($sql)`, `addOrder()`,
`setJoinType('inner'|'left')`, `setSql()`, `setLimit()`, `setOffset()`, `queryRange($offset,$limit)`,
`setTimeout()`, `setHttpOption()`. Public flag `$getCount` switches a SELECT to `COUNT(...)`.

`compileTablesFields()` builds the FROM/JOIN clause (INNER/LEFT), knows how to join UDF tables,
`dpaddress`/`dpaddressmailings`, `dpflags` and `dpusermultivalues` to their parent by the right
key. `compileWhere()` ANDs the added conditions.

## Executing

`execute()` dispatches to `execute{Type}()`. SELECTs are paged 500 rows at a time using a
`ROW_NUMBER() OVER (...)` window (DonorPerfect returns max 500/1000 rows per call);
`retrieveAllTableData` pages 400 at a time. `executeSelectApiCall()` memoizes identical SELECT SQL
in a `drupal_static('dpquery_select_calls')` so a repeated query is not re-sent.

`executeApiCall()` (the transport):
- For a predefined procedure: `?action={dpAction}&params={paramsString}&{authString}`.
- For SQL ≤ 255 chars: `GET ?action={sql}&{authString}`.
- For SQL > 255 chars: `POST ?{authString}` with the SQL sent as `form_params[action]`.
- `filterString()` replaces `#`→`Number ` and `&`→`and`; spaces are `%20`-encoded.
- The response body is XML, parsed with `SimpleXMLElement`; each `<record>/<field name value>` pair
  becomes an associative row in `$this->result`. `resultCode` holds the HTTP status.
- After a `dp_savedonor` / `dp_savegift` / `dp_savecontact` / `dp_saveotherinfo` procedure the new
  id is reshaped into `$this->result['donor_id'|'gift_id'|'contact_id'|'other_id']`.

Result helpers: `fetchField()` (first value), `resultObjects()` (array of stdClass, for Views),
`listFields()` (the cached field map).

## Save/update behavior

`executeSaveDonor()` / `SaveGift` / `SaveContact` / `SaveOtherInfo`: if the id param is 0/absent
they call the DonorPerfect "save" procedure to create the record, then run follow-up `update`
queries against the base + UDF tables for any remaining params. INSERT/UPDATE queries stamp
`created_by`/`created_date` or `modified_by`/`modified_date` with `web:<first 16 chars of the
current Drupal display name>` and the current date. String/date proc params are single-quoted via
`addSingleQuotes()`, which escapes embedded single quotes (`'` → `''`).

## Value quoting

`addSingleQuotes()` doubles single quotes and wraps the value in quotes. `procFields` per procedure
(in `getProcFields()`) declare each param's type (`n` numeric, `d` date, `c` character) and drive
whether a value is quoted.

## Refreshing the metadata cache

`refreshCache()` (on DPQuery) runs `loadDpCodes()`, `loadDpMultivalues()`, `loadDpTables()` — these
query DonorPerfect's `dpcodes`, `dpuserfields`, `sd_field`/`sd_section` and each available table,
build the field/code/multi-value definitions, and write them to config object `donorperfect.cache`
(`dpcodes`, `dpmultivalues`, `dptables`). `EntityBase::baseFieldDefinitions()` and the settings form
read this cache. Triggered from the UI via the refresh-cache route
(see [../config/settings.md](../config/settings.md)).

## DPUtility helpers (`donorperfect.dputility`)

`apiCredentialsLoad/Validate/Save` (credential storage + the three alter hooks), `getCache('codes'|
'tables'|'multivalues')`, `getCodesAsOptions()` / `getCodeDescription()`, `getFieldsAsOptions()`,
`getEntityFieldInfo()` (which selected fields become entity base fields), `getFieldDefaults()`
(altered by `hook_donorperfect_field_defaults_alter()`), `getAddressString()`/`getCsz()`,
`entityLoad()`/`entityLoadMultiple()`, name-casing helpers, plus field max-length constants.
