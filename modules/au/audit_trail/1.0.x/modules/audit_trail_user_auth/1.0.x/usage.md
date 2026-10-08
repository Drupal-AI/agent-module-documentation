<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Chains user-authentication events — login, logout, failed login, password reset requested/probed/used, account block/unblock, create/delete, and password/role changes — into the tamper-evident audit trail.

---

`audit_trail_user_auth` bridges the security-relevant lifecycle of an account session into the chained audit trail on channel `audit_trail_user_auth` (claimed by its own chain entity so the security signal stays separate from operational logs). Verbs: `login` and `password_reset_used` (split by the `user.reset.login` route), `logout`, `login_failed` (a last-position login-form validate handler recording the submitted name against `user:anonymous`), `password_reset_requested` vs `password_reset_probed` (a password-form submit handler splitting on whether an account resolved — the probe stream is the classic username-enumeration signal, logged at WARNING), `account_blocked`/`account_unblocked`, `password_changed` and `role_changed` (all from `hook_user_update` diffs), `account_created` (`user_insert`) and `account_deleted` (`user_delete`). No password material is ever recorded — only the action verb, and for reset/failed-login the typed identifier for enumeration triage. Every verb is per-event opt-in via `audit_trail_user_auth.settings:events`. The base `audit_trail` module provides the tamper-evidence. Requires `audit_trail` and core `user`.

---

- Keep a tamper-evident record of every successful login and logout.
- Detect brute-force attempts by querying the `login_failed` stream.
- Spot username/email enumeration via the `password_reset_probed` (WARNING) stream.
- Distinguish a password-reset-link login from a normal form login (`password_reset_used`).
- Audit account blocks and unblocks as dedicated security verbs.
- Record password changes as a verb without ever storing the hash or password.
- Track role grants/revocations with a per-item added/removed diff (`role_changed`).
- Log account creation and deletion for a SIEM to alert on.
- Feed the auth chain to a SIEM by filtering the `audit_trail_user_auth` channel.
- Turn individual auth verbs on or off per site via the events config.
- Investigate an incident with a chronological, verifiable auth timeline per user.
- Keep security-signal auth events isolated from noisy operational dblog entries.
- Configure enabled events at Configuration → System → Audit Trail → User authentication events.
