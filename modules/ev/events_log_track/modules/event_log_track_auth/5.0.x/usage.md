Enables authentication tracking for Events Log Track: successful logins, logouts, password-reset requests, failed login attempts, and unauthorized (403) access all appear in the audit report with type `authentication` (403s as type `authorization`).

---

`EventLogTrackAuthHooks` registers the `authentication` handler and implements `hook_user_login` and `hook_user_logout` (recording username, uid, and a live session count via the parent manager's `sessionCount()`), skipping anonymous (uid 0) logins that can occur with 2FA. Password-reset requests are captured through the parent's form-submit dispatch on the `user_pass` form; failed logins are captured by a `#validate` callback added to the login form that logs the validation errors as a `fail` operation. Separately, `EventLogTrackAuthExit` subscribes to the kernel terminate event and logs an "Unauthorized access attempt" (`authorization`/`fail`) on every 403 response. All entries write through the parent `event_log_track.manager` service, inheriting filtering, retention, and the `access event log track` permission. The `event_log_track_tfa` submodule extends this with two-factor login tracking.

---

- Audit successful user logins with a running session count.
- Track logouts and remaining active sessions.
- Record password-reset requests per account.
- Capture failed login attempts and the reason.
- Log unauthorized (403) access attempts site-wide.
- Filter the audit report to only authentication events.
- Detect brute-force patterns from repeated `fail` events.
- Investigate suspicious logins by IP address.
- Correlate a security incident with account activity.
- See concurrent-session counts per user over time.
- Distinguish password resets from actual logins.
- Demonstrate authentication-audit compliance.
- Prune old authentication records via cron retention.
- Export a report of login activity for an account.
- Spot spikes in 403 responses indicating probing.
