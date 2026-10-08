<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Debug report, metrics & preview

## Editorial debug page
Route `mautic_audiences.debug` → `\Drupal\mautic_audiences\Form\DebugForm` at `/admin/reports/mautic-audiences` (perm `administer mautic audiences`, `_admin_route`, `no_cache`). All reads go through the production resolver, including the consent gate.

![Mautic Audiences debug report](../../../../../../../screenshots/mautic_audiences/1.1.x/report.png)

Sections (`DebugForm`):
- **Current viewer** — authenticated?, `mtc_id` cookie, consent-gate state, and the resolved audience (contact id, segments, tags, hash, updated, empty?).
- **Audience lookup** — inspect an arbitrary identity: by Drupal user (entity autocomplete), by email (local user, else strategy email→contact), or by Mautic contact id. **Inspect** reads through the resolver; **Refresh from Mautic** calls `resolver->refresh()` first (the same signature-validated path the webhook and Drush use). Result shows the data source (user.data / keyvalue / Mautic API).
- **Twig functions (live preview)** — evaluates `is_in_segment(...)`, `has_tag(...)`, and `current_audiences().hash` / `.is_empty()` for the current viewer against illustrative probe names.
- **Operational metrics**, **Storage**, **Active configuration** — see below.

## Operational metrics (`Service/Metrics.php`, service `mautic_audiences.metrics`)
Coarse `state`-backed counters (read-modify-write; lost updates acceptable). Counters: `api_calls_total`, `api_calls_failed`, `webhooks_received_total`, `webhooks_rejected_signature`, `webhooks_deduplicated`, `consent_denied_total`; timestamps `last_api_call_ts`, `last_webhook_ts`. The debug page renders them and offers **Reset counters** (`Metrics::reset()`). Hot-path resolves/cache-hits are deliberately not counted.

## Storage & config sections
Storage shows authenticated-audience `users_data` rows, anonymous `keyvalue.expirable` entries, and webhook events in the idempotency window (`mautic_audiences.processed_events`). Config shows the identity strategy, `anonymous_ttl`, `idempotency_window`, consent callback, and whether a webhook secret is set in config.

## Preview-as-audience
Permission `preview mautic audiences` (`restrict access: true`). Append URL params on any URL:
- `?ma_preview_segments=vip,newsletter` and/or `?ma_preview_tags=lead,hot` — set a session preview.
- `?ma_preview_clear=1` — clear it.

`PreviewSubscriber` (`src/EventSubscriber/`, request priority 256) writes the payload to the session only for permitted users (others' params are ignored). `AudiencesPreviewDecorator` (decorates `mautic_audiences.resolver`) then returns a synthetic `AudiencesValue` (contactId `preview`) from `resolve()` — the background methods (`resolveForUser`/`resolveForContact`/`refresh`) pass through unchanged. The synthetic hash differs from the real one, so preview renders fragment separately in cache. `PreviewBannerSubscriber` injects a yellow banner (with a clear-preview link) after `<body>` on HTML responses while a preview is active.
