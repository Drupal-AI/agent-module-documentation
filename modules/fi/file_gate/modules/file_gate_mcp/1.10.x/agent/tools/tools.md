<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate MCP — the five tools

All tools live in `src/Plugin/tool/Tool/`, extend `FileGateToolBase`, and are declared with `#[Tool(...)]`
attributes. Enable with `drush en file_gate_mcp`. Governance (permission recheck, policy profile, rate limit,
response-size cap, fixed-message refusals, no secrets/paths/URLs) is described in `../start.md`.

## Shared base — `FileGateToolBase`
- `checkGovernedAccess()` / `checkGovernedDiscoveryAccess()` → `allowedIfHasPermissions([use file gate mcp tools,
  …extraPermissions])`, cache max-age 0.
- `doExecute()` rechecks access, resolves the profile (NULL → refuse), applies the rate limit, runs `run()`,
  refuses if the JSON result exceeds `resultLimit($profile)`, else returns `ExecutableResult::success`.
- `fieldKey()` validates `entity_type.field_name` against `/^[a-z][a-z0-9_]{0,31}\.[a-z][a-z0-9_]{0,31}$/D`.

## `file_gate_status` — `StatusTool` (Read)
No inputs. Returns `{findings_available, findings:[{id,severity,title,value}], any_secret_configured,
named_secrets:[{id,has_field_scope}], gated_fields:[{field_name,storage,entity_type,bundle,method,scheme,
protected}], settings:{ttl,disposition,require_acting_account}}`. `protected` is `scheme === 'private'`. Findings
come from `\Drupal\file_gate\Hook\FileGateRequirements::runtime()` (service resolved defensively; NULL when
absent). Reports secret **ids** only, never material.

## `file_gate_file_gate` — `FileLookupTool` (Read)
Inputs: exactly one of `file` (UUID) or `media` (UUID), each `Uuid`-constrained (and re-checked against a strict
regex in `run()`). A media UUID resolves only when `$media->access('view', currentUser)` (file entities have no
meaningful view access — core denies view on every gated file — so a file UUID resolves for any tool-permission
holder; this is a lookup, not delivery). Returns `{found, file, scheme, gated, field, method, gated_fields[],
system_files_url_serves_it, how_to_download}` and, for media, `media_published` (+ a note when gated and
unpublished). No path or URL.

## `file_gate_grants_list` — `GrantsListTool` (Read)
Input: `field` (regex-constrained; must be a gated field per `GatedFieldOverview::fields()`). Reads
`GrantInventory::listForField($field)` (no secret filter — site-operator view across every minting secret).
Returns `{field, total, truncated, grants:[{grant_id,file,expires,max_uses,subject_bound,secret_id,created}]}`,
newest first, ≤200 rows. `subject_bound` is a bool only (the stored `sh` is an unkeyed hash of a caller-asserted
subject, so it is never returned). A grant id is for revocation, **not** a download token.

## `file_gate_metrics` — `MetricsTool` (Read)
Input: `days` (1–90, default 14, `Range`-constrained). Returns `{metrics: FileGateMetrics::summary($days)}`
(mints, deliveries, denials, auth failures; per-day, per-method, top-10 file UUIDs; `available:false` when dblog
is off). Counts cover at most the 5000 newest log entries.

## `file_gate_grant_revoke` — `GrantRevokeTool` (**Write** + `revoke file gate grants via mcp`)
Inputs: `field` (regex-constrained) and `grant_id` (`/^[A-Za-z0-9_-]{8,128}$/D`). Checks: the field must be gated;
`GrantInventory::meta($grant_id)` must exist **and** its stored `field` must equal the requested field (a guessed
or copied id from another field is refused). Revokes via `GrantInventory::revokeJti()` with a kill-mark TTL of
`max(DEFAULT_KILL_TTL, remaining + 3600)` so a long-lived grant cannot become redeemable again when the default
30-day mark lapses. Cannot be undone (the holder needs a new grant); one grant per call (no bulk form). Audited
(`kind: jti`, `secret_id: mcp`, `uid`). It is a **Write** operation (mutates a grant), which is why it carries its
own restricted permission on top of the shared read permission — the read tools stay Read.
