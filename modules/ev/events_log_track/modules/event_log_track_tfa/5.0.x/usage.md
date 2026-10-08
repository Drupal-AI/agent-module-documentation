Enables two-factor (TFA) login tracking for Events Log Track: completing the TFA challenge is recorded in the audit report with type `authentication_tfa` and operation `TFA login`, complementing the login/logout events from `event_log_track_auth`.

---

`EventLogTrackTfaHooks` registers the `authentication_tfa` handler and hooks the TFA entry form (`tfa_entry_form`) through the parent's form-submit dispatch. When a non-anonymous user completes the second factor, `formSubmit()` records a `TFA login` entry whose description carries a session count (`SC(<n>)`, via the parent manager's `sessionCount()`), with the uid in both `uid` and `ref_numeric` and the username in `ref_char`. It requires the `event_log_track_auth` submodule and the contrib TFA module. Entries write through the parent `event_log_track.manager` service, inheriting filtering, retention, and the `access event log track` permission.

---

- Audit successful two-factor authentications.
- Distinguish TFA logins from password-only logins in the report.
- Track the session count at the moment of a TFA login.
- Filter the audit report to only `authentication_tfa` events.
- Verify that privileged accounts completed two-factor login.
- Investigate a suspicious login that bypassed or used TFA.
- Correlate TFA logins with the account and IP.
- Demonstrate strong-authentication compliance.
- Combine with `event_log_track_auth` for a full login trail.
- Detect accounts that never complete the TFA step.
- Prune old TFA records via cron retention.
- Export a report of two-factor logins for an account.
- Spot unusual TFA login times for an admin.
- Confirm TFA enforcement after a policy change.
- Trace a user's TFA login history by uid (`ref_numeric`).
