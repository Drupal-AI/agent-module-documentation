Enables masquerade tracking for Events Log Track: when an administrator starts or stops impersonating another user (via the contrib Masquerade module), the action appears in the audit report with type `masquerade`.

---

`EventLogTrackMasquerade` subscribes to the kernel request event and matches Masquerade's routes: `entity.user.masquerade` logs a `masquerade` event naming the admin and the target user (both name and uid), and `masquerade.unmasquerade` logs an `unmasquerade` event, reconstructing the original admin from the session metadata bag. `EventLogTrackMasqueradeHooks` registers the `masquerade` handler so these show up in the report's filters. The actor details live in the description; entries write through the parent `event_log_track.manager` service, inheriting filtering, retention, and the `access event log track` permission. This gives an accountability trail for one of the most sensitive administrative capabilities.

---

- Audit every time an admin impersonates another user.
- Record who was impersonated and by whom.
- Track when a masquerade session ends (unmasquerade).
- Filter the audit report to only `masquerade` events.
- Investigate actions taken while masquerading.
- Detect misuse of the impersonation feature.
- Demonstrate accountability for privileged support actions.
- Correlate a user complaint with a masquerade session.
- See the admin uid and target uid for each session.
- Prune old masquerade records via cron retention.
- Export a report of impersonation activity over a period.
- Combine with content/auth tracking to attribute masqueraded actions.
- Confirm support staff only impersonate authorized accounts.
- Spot unusually frequent masquerading by an account.
- Provide evidence for security or privacy reviews.
