<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST API

Three REST resource plugins under `src/Plugin/rest/resource/`, all extending `EtTransactionResourceBase`. Activated
by `expense_tracker_update_9006()` (or the shipped `config/install/rest.resource.*.yml`) with `granularity: method`,
format `json`, auth `cookie` + `basic_auth`. Write operations from same-origin JS need an `X-CSRF-Token`
(`GET /session/token`). Enable the module's `basic_auth`/`rest` dependencies and grant the relevant `restful *`
permissions.

## Endpoints
`EtTransactionResource` (id `et_transaction`):
- `POST /api/et-transactions` — create. Requires `create expense_tracker`. Required body: `title`, `amount`,
  `transaction_type` (or alias `type`, income|expense). Returns 201 `{data: {...}}`.
- `GET /api/et-transactions/{id}` — retrieve one.
- `PATCH /api/et-transactions/{id}` — partial update.
- `DELETE /api/et-transactions/{id}` — delete.
- Single-record reads/writes resolve the entity through `loadOrFail()`, which loads by id and then enforces the
  entity's own `view` access; `patch`/`delete` additionally call `$entity->access('update'|'delete')`. A missing id
  yields 404; a denied one yields 403.

`EtTransactionCollectionResource` (id `et_transaction_collection`):
- `GET /api/et-transactions` — filterable, sorted, paginated list. Requires `restful get et_transaction_collection`.
- Query params (all optional): `filter_type` (income|expense), `filter_from` / `filter_to` (Y-m-d or UNIX ts),
  `filter_author` (user id), `filter_category` (category entity id), `filter_status` (1|0|all, default 1),
  `filter_created_type` (manual|automatic), `filter_repeat` (1|0), `search` (title LIKE), `ids` (comma list),
  `page` (0-based), `per_page` (1–500, default 150), `sort` (id|date|amount|title|created|changed, default date),
  `sort_dir` (ASC|DESC), `fields` (comma allowlist), `with_totals` (0 to omit income/expense/net totals).
- Response: `{data: [...], meta: {total, page, per_page, pages, totals?}, links: {self, first, last, next, prev}}`.

`EtTransactionImportResource` (id `et_transaction_import`):
- `POST /api/et-transactions/import` — bulk create/update. Requires `import expense_tracker`.
- Body: `{transactions: [ {title, amount, transaction_type|type, date?, note?, ...}, ... ], skip_duplicates?: true,
  update_existing?: false}`. Per-row validation requires title, amount (numeric ≥ 0) and transaction_type.
  Duplicate key = title + calendar-day date + transaction_type. Returns 200 (all ok) or 207 (partial) with
  `{created, updated, skipped, errors[], total_rows}`.

## Serialization helpers (`EtTransactionResourceBase`)
- `normalizeEntity()` builds the JSON body (id, uuid, title, amount, amount_formatted, date/date_iso,
  transaction_type/category, category_id, note, repeat, status, created_type, author {id,name}, created/changed,
  langcode, `_links`) and invokes `hook_et_transaction_api_normalize_alter`.
- `denormalize()` maps input keys → field names (incl. `type`→transaction_type, `category_id`→category) and passes
  unknown keys through verbatim; callers set only fields that pass `$entity->hasField()`.
- `requireFields()`, `validateTypes()`, `validateEntity()` (runs `$entity->validate()` → 422 on violations),
  `requestBody()` (safe JSON fallback), `respond()` (adds cache contexts `url.query_args`, `user.permissions` and
  tag `et_transaction_list`).

## Alter hooks (`expense_tracker.api.php`)
- `hook_et_transaction_api_normalize_alter(&$data, $entity)` — reshape a record's JSON output.
- `hook_et_transaction_api_create_alter(&$values, $input)` — adjust field values before a POST create.
- `hook_et_transaction_api_update_alter(&$values, $input, $entity)` — adjust values before a PATCH save.
- `hook_et_transaction_collection_query_alter($query, $params)` — add conditions to the collection query.
- `hook_et_transaction_import_row_alter(&$values, $row)` — map custom columns for both the REST import and the
  file-upload import form.
