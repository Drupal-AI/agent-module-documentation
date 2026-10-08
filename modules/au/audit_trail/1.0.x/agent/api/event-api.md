<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Write API: chained PSR-3 and AuditTrail::event()

Two ways to land a row in a chain. Both end at `AuditTrailChainWriter::write()`, which acquires the per-chain lock, canonicalises the payload, computes `hash` + `hmac`, and INSERTs.

## Path 1 — PSR-3 logger (`src/Logger/AuditTrailLogger.php`)
`audit_trail.logger` is the only `logger`-tagged service, so every `\Drupal::logger($channel)->log()` reaches it alongside dblog/syslog. It chains an entry only when:
- context has `'chain' => TRUE` (or `'chain' => '<chain-id>'` to target a specific chain), OR
- the channel is claimed by an `audit_trail_chain` whose `mode` is `auto` (`ChainRegistry::hasAutoChannel()`).

`'chain' => FALSE` short-circuits immediately (used internally to fan out to non-audit sinks). The whole body is wrapped in try/catch — PSR-3 forbids throwing — and a failed chained write is reported through `DroppedEventReporterInterface` (PHP error_log in prod), never through `logger.factory` (cycle constraint, issue #3591791). PSR-3 ingress lands its entire context in the **transient** tier only; permanent payload requires Path 2. `ForensicStamp` stamps `uid` / `ip` / `request_uri` / `message_template` into transient.

Recognised context keys on this path: `channel`, `action`, `resource`, `_audit_trail_correlation_id`; `chain`/`exception`/`backtrace` are stripped.

## Path 2 — structured `AuditTrail::event()` (`src/AuditTrail.php`)
Inject the `audit_trail` service (`Drupal\audit_trail\AuditTrailInterface`) and call:
```php
$auditTrail->event(
  string $channel,
  string $action,
  AuditTrailSubject $subject,      // resource + optional live entity
  array $context = [],
  int $severity = RfcLogLevel::NOTICE,
  ?string $correlation_id = NULL,
);
```
`AuditTrailSubject` (`src/AuditTrailSubject.php`) carries `resource` (the indexed identifier string, conventionally `entity:<type>/<id>`, `file:<fid>`, `user:<uid>`, …) and `live` (the subject entity, so contributors can snapshot it without reloading).

Pipeline in `dispatchEvent()`:
1. Resolve the chain for `$channel` via `ChainRegistry::resolve()` (shared with Path 1 so a channel can't resolve two ways).
2. Run the chain's **filters** in ascending weight; the first `shouldEmit() === FALSE` short-circuits (and, if `rejectsSilently()`, suppresses the other loggers too).
3. Run the chain's **context contributors** in ascending weight; each returns `['permanent' => [...], 'transient' => [...]]`, merged per tier last-write-wins. Buggy plugins are caught, reported with `chain: FALSE`, and the row still lands (a `_contributor_errors` marker goes into transient).
4. `ForensicStamp::apply()` stamps the transient bucket (with precedence over caller context so the recorded actor is the framework-observed one); `before`/`after` keys fold into the canonical snapshot-delta shape.
5. `$writer->write()` directly — no PSR-3 round-trip for the chain row.
6. Separately fan out a plain PSR-3 `chain: FALSE` line to dblog/syslog unless the chain (or caller) is `chain_only`.

Caller-attested permanent payload: pass `'_audit_trail_permanent' => [...]` in `$context` to seed the permanent bucket directly. Default-routing sends all other plain context keys to transient (permanent is operator-attested only).

## Completeness contract
`event()` does **not** swallow a writer failure — audit completeness is part of tamper-evidence, so the caller (bridge/host op) must decide how to handle a dropped row (retry, abort its own transaction, alert). Only plugin failures are caught internally.

## Correlation id & transaction modes
`correlation_id` is an opaque caller-provided id shared by every row in one logical operation, stored in the indexed `correlation_id` column (not part of the canonical). When a write happens inside a caller's open DB transaction, `in_transaction_write_mode` (settings) decides handling: `outbox` (default, staged in `audit_trail_outbox`, chained on commit), `memory`, or `inline`. See [architecture/chain.md](../architecture/chain.md).
