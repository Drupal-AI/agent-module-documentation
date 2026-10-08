<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Update Notification Disable turns off core's update notification and removes the warning about the Update Status module not being enabled.

---

Update Notification Disable turns off Drupal core's update notifications — and removes the status-report
warning that appears when the Update Status module is not enabled — so administrators no longer see prompts
about available updates or the "Update status module not enabled" warning.

**Security caveat — this suppresses the warnings that keep a site patched, which is a risky choice.** Core's
update notifications exist to tell administrators when **security updates** are available; disabling them
means the site can silently fall behind on security patches (the single most important defense against known
vulnerabilities). Sites sometimes do this because updates are managed externally (Composer + a
patch/monitoring pipeline, or a platform that handles updates) — that is the **only** context in which
disabling the in-Drupal notification is defensible, and only if an equivalent external process reliably
surfaces available security updates. **Do not enable this module unless updates are demonstrably tracked and
applied by another reliable mechanism** — otherwise it removes a critical safety net. It has no
content-access role.

---

- Turn off core update notifications.
- Remove the Update-Status-disabled warning.
- Suppress update prompts.
- Understand this hides SECURITY-update warnings.
- Know it is a risky choice.
- Only use if updates are tracked externally.
- Ensure an external process surfaces security updates.
- Not fall behind on patches.
- Not enable without reliable update tracking.
- Remove a critical safety net (be careful).
- Have no content-access role.
- Manage updates via Composer/pipeline instead.
- Confirm security updates are still surfaced.
- Avoid silent patch drift.
- Weigh the risk carefully.
- Disable notifications deliberately.
- Keep patching another way.
- Suppress the warning knowingly.
- Understand the security tradeoff.
- Not hide updates blindly.
