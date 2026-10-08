<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP endpoints & JavaScript API

Three routes in `mautic_audiences.routing.yml`, all `no_cache: TRUE`, plus the client library `mautic_audiences/audiences` (`js/audiences.js`).

## `POST /mautic-audiences/webhook`
`WebhookController::handle()` (`src/Controller/WebhookController.php`), `_access: TRUE` — the caller is Mautic, not a logged-in user, so there is no `_permission`. Flow:
1. Flood control (`mautic_audiences.webhook`, 600 requests / 60 s) → 429 when exceeded.
2. Empty body → 422; `WebhookController::verifySignature()` validates an HMAC over the raw body against the `Webhook-Signature` header. Mautic signs as `base64(hash_hmac('sha256', body, secret, true))`; a hex form is also accepted; comparison uses `hash_equals()`. The secret is read from `mautic_audiences.settings:webhook_secret`, falling back to `$settings['mautic_audiences.webhook_secret']`.
3. JSON-decodes the payload (Mautic event shape: `{ "mautic.lead_post_save_update": [ { "contact": {"id": 123}, "timestamp": ... }, ... ], ... }`), extracts each event's contact id (`contact.id` or `lead.id`), deduplicates via a `state` idempotency log (`mautic_audiences.processed_events`, window = `idempotency_window`, capped at 5000), and calls `resolver->refresh($contact_id)` per new event.
4. Returns `{status: ok, processed, deduped, skipped}`; updates metrics (`webhooks_received_total`, `webhooks_deduplicated`, `webhooks_rejected_signature`, `last_webhook_ts`).

Set the endpoint URL and matching secret in the Mautic webhook config. `refresh()` re-fetches authoritative data from Mautic and writes local stores; the webhook body is never trusted as audience data itself.

## `GET /mautic-audiences/me`
`MeController::resolve()`, `_access: TRUE`. Returns metadata **about the current request's visitor only** (resolved via `resolver->resolve()` — no id/user parameter is accepted): `contact_id_present` (bool), `hash`, `counts.{segments,tags}`, and `segments`/`tags` name arrays. The name arrays are **empty by default**; they list only entries matching `exposed_segments` (exact) / `exposed_tag_prefixes` (`str_starts_with`). Response is `Cache-Control: private, max-age=60` with `Vary: Cookie`.

## `POST /mautic-audiences/check`
`CheckController::check()`, `_access: TRUE`. Body `{segments:["vip"], tags:["coupon:X"]}` (each list normalized to distinct non-empty strings, capped at 50). Answers booleans for the caller-supplied names only (`{segments:{vip:true}, tags:{...}}`) against `resolver->resolve()` — it never enumerates the audience, so no name inventory is returned. Response is `Cache-Control: private, max-age=60`, `Vary: Cookie`.

## JavaScript API (`Drupal.mauticAudiences`, `js/audiences.js`)
Attach the `mautic_audiences/audiences` library.
- `hasSegment(name)` / `hasTag(name)` → `Promise<boolean>`; batched within a microtask into one POST to `/check`, cached in memory for the session.
- `list()` → resolves the `/me` payload (metadata + any allowlisted names).
- `reset()` → drops the in-memory cache.
Network/parse failures degrade to all-false.
