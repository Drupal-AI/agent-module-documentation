<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Trail User authentication events (audit_trail_user_auth) — agent index

Submodule of [audit_trail](../../../../agent/start.md). Core `^11.3 || ^12`. Depends on `audit_trail`, core `user`.

## What it does
`AuditTrailUserAuthHooks` (`src/Hook/AuditTrailUserAuthHooks.php`) bridges account-session events onto channel `audit_trail_user_auth` (resource `user:<uid>` or `user:anonymous`), each `AuditTrail::event()`-dispatched and gated by `audit_trail_user_auth.settings:events.<action>` (all true by default). Hooks/verbs:
- `#[Hook('user_login')]` → `login`, or `password_reset_used` when the route is `user.reset.login`.
- `#[Hook('user_logout')]` → `logout`.
- `#[Hook('user_insert')]` → `account_created`; `#[Hook('user_delete')]` → `account_deleted`.
- `#[Hook('user_update')]` → diffs: status flip → `account_blocked` / `account_unblocked`; password-hash change → `password_changed`; roles change → `role_changed` (carries a `SnapshotDelta` roles fragment for the per-item diff).
- `#[Hook('form_user_login_form_alter')]` → appends `logFailedLogin` validate handler: if any error is present, logs `login_failed` with the submitted name against `user:anonymous`.
- `#[Hook('form_user_pass_alter')]` → appends `logPasswordResetRequest` submit handler: `password_reset_requested` (NOTICE, `user:<uid>`) when an account resolved, else `password_reset_probed` (WARNING, `user:anonymous`) — the enumeration signal.

## Security note (public-safe)
No password material is ever recorded — only the action verb, and for reset/failed-login the typed identifier for triage. The stored password hash is compared but never entered into context.

## Provides
- Chain: `audit_trail.chain.audit_trail_user_auth` (claims channel `audit_trail_user_auth`).
- Config: `audit_trail_user_auth.settings:events` (12 per-verb booleans). Schema `audit_trail_user_auth.settings`.
- Route/form: `audit_trail_user_auth.settings_form` `/admin/config/system/audit-trail/user-auth` (permission `administer audit trail`). No own permissions.
