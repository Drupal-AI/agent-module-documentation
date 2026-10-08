<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost read-only introspection tools

All in `src/Plugin/Tool/`, extending `DroostToolBase` (id via `#[Tool(id: …)]`, `readOnly: TRUE`).
Each returns `{success, message, data}`. None are gated — introspection is always available. They run
over either transport (STDIO/Drush or, if the operator exposes it, HTTP `/_mcp`).

## The base class — `DroostToolBase`

- `succeed($message, $data)` / `fail($message)` build the envelope; `defaultConfiguration()` returns
  `['enabled' => TRUE]` so tools register without an admin UI.
- Arg coercers used everywhere: `stringArg`, `intArg` (clamped), `boolArg` (treats `"false"/"0"/"no"`
  strings as FALSE), `stringListArg`, `toString` (handles `\Stringable` labels).
- `shielded(callable)` runs work inside a private `\Fiber` to absorb the renderer's fiber suspensions
  that the MCP SDK would otherwise misread — wrap any body that renders/rebuilds.

## The tools

- **`droost_app_info`** — Drupal + PHP versions, install profile, site name, environment summary.
- **`droost_entities`** — entity type + field *definitions* (types, cardinality, bundles).
- **`droost_entity_load`** — one entity's raw field values by id or uuid; optional `fields` filter.
  Runs **no** entity/field access checks (raw stored values, incl. unpublished/other users'); masks
  fields whose name looks sensitive via `SecretRedactor`. Documented as trusted-local-STDIO only.
- **`droost_routes`** — routes with paths, defaults, requirements; filter by prefix/name.
- **`droost_services`** — service list; **`droost_service`** (id `droost_service`, `ServiceInfo.php`)
  answers "which interface do I type-hint to autowire this, and what was it called before?".
- **`droost_permissions`** — declared permissions with titles/providers.
- **`droost_config_get`** — one config object's values (via `SecretRedactor::redact`), or list config
  names by `prefix`. **`droost_config_status`** — active-vs-sync config diff summary.
- **`droost_db_read`** — a single read statement (SELECT/WITH/SHOW/DESCRIBE/EXPLAIN). Rejects
  non-read leading verbs and multi-statements (`SqlVerb`); pushes a `LIMIT` and a `MAX_EXECUTION_TIME`
  hint into a bare SELECT; prefers an operator-configured read-only connection target
  (`droost_readonly`) when present. **`droost_db_schema`** — table/column schema.
- **`droost_logs`** / **`droost_last_error`** — recent dblog entries / the last error
  (`DblogToolBase` decodes the serialized `variables` with `unserialize(…, ['allowed_classes' => FALSE])`).
- **`droost_tokens`** — available tokens (sensitive base fields masked via `SecretRedactor`).
- **`droost_url`** — absolute URL from an internal `/path` or a `route` + `parameters` (internal only;
  no request-supplied outbound URL).
- **`droost_runtime_inspect`** — introspects a live service/object by id.
- **`droost_sdc_components`** — Single-Directory Components inventory.
- **`droost_module_docs`** — reads a module's shipped docs (`ModuleDocReader`, path-contained).
- **`droost_guidelines`** — Droost's house guidelines corpus (`GuidelineProvider`).
- **`droost_update_status`** — available module updates.
- **`droost_doctor`** — knowledge-store freshness verdict (mirrors `drush droost:doctor`, via the
  `droost.doctor` service).

## Secret redaction (`SecretRedactor`)

Shared by `droost_config_get`, `droost_config_set` (echo), `droost_entity_load`, `droost_tokens`, and
the search indexer. `isSensitive()` splits a key into segments (on non-alphanumerics + camelCase) and
matches whole segments against a needle list (`pass`, `secret`, `token`, `key`, `apikey`, `dsn`,
`bearer`, `oauth`, `cert`, `jwt`, `webhook`, …) — so `author`/`compass`/`certain` are not falsely
redacted. Per-entity-type `SENSITIVE_BASE_FIELDS` add name-innocuous fields (`user.mail`,
`comment.hostname`, …). It is a best-effort key-name heuristic, not a content classifier.
