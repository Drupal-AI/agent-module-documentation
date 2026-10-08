<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled JSON Log (decoupled_json_log) — agent index

**A write-only `log_json` entity for decoupled front ends to POST JSON error logs, with per-log-type rate limits and payload size caps.**

- **Version:** 1.1.x · **Core:** ^11.3 || ^12 · **PHP:** >=8.5 · **Depends on:** json_field (^1.7)
- **Config route:** `decoupled_json_log.settings_form` → `/admin/config/decoupled_json_log` (permission `administer log_json types`).
- **Permissions:** `create/view/edit/delete log_json`, `administer log_json types`. Only `create log_json` is unrestricted; the rest are `restrict access: true`.
- **API posture:** `DecoupledJsonLogLimitingRouteSubscriber` removes JSON:API PATCH/DELETE for `log_json` and gates GET behind `administer log_json types`; only POST/create is exposed. REST resource `entity.log_json` enables POST only (json/xml, cookie auth).
- **Rate limiting:** `RateLimitPerUser` constraint, counted **per bundle** (defaults 500 anon / 50 authenticated per 86400 s). Each log type can override count_anon/count_auth/interval; `0` rejects all client submissions to that type.
- **Payload caps:** `MaxPayloadSize` constraint rejects entries over `max_payload_bytes.log` (64 KB) / `max_payload_bytes.device_info` (8 KB) and logs the rejection.
- **Anti-spoofing:** `LogJson::preSave()` always stamps `uid` (current user) and `created` (request time) on new entries, so clients can't dodge the rate limit by spoofing author or backdating.
- **Security posture:** create is reachable by whichever roles you grant `create log_json` (commonly anonymous, by design) and is CSRF-protected for session auth; reads/edits/deletes over the API are removed or admin-gated.

See [api/logging.md](api/logging.md)
