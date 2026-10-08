<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled JSON Log (decoupled_json_log) — agent index

**A write-only `log_json` entity for decoupled front ends to POST JSON error logs, with per-user daily rate limits.**

- **Version:** 1.0.x · **Core:** ^11.2 · **Depends on:** json_field
- **Config route:** `decoupled_json_log.settings_form` → `/admin/config/decoupled_json_log` (permission `administer log_json types`).
- **Permissions:** `create/view/edit/delete log_json`, `administer log_json types` (restricted).
- **API posture:** `DecoupledJsonLogLimitingRouteSubscriber` removes JSON:API PATCH/DELETE for `log_json` and requires a permission on GET; only POST/create is exposed.
- **Rate limiting:** `RateLimitPerUser` constraint (defaults 500 anon / 50 authenticated per day).
- **Security:** create endpoint is reachable by whichever roles you grant `create log_json` (commonly anonymous, by design) and is CSRF-protected for session auth; reads/edits/deletes over the API are removed or admin-gated. Note the GET route subscriber sets requirement to permission string `administer log_json type` (singular) while the defined permission is `administer log_json types` (plural) — a mismatch, but it fails closed.

See [api/logging.md](api/logging.md)
