<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Session Reminder displays a modal before the Drupal session cookie expires.

---

Session Reminder **warns the user before their session expires** — showing a modal shortly before the
Drupal session cookie times out, so users can extend their session and avoid losing unsaved work (or being
silently logged out). It depends on core User.

Use it to give a session-timeout warning. This is a **usability/security-adjacent** feature — a timeout warning
helps with both UX (don't lose work) and security awareness (the user knows the session is ending). It reflects
the session lifetime; it does not itself change session security (core still controls the actual timeout). It
has no access-control role. Configure the warning timing.

---

- Warn before session expiry.
- Show a timeout modal.
- Let users extend the session.
- Depend on core User.
- Avoid losing unsaved work.
- Improve timeout awareness.
- Reflect the session lifetime.
- Not change core session security.
- Have no access-control role.
- Configure the warning timing.
- Handle session reminders.
- Warn on timeout.
- Configure the modal.
- Handle the session.
- Show a warning.
- Configure timing.
- Handle the reminder.
- Remind on expiry.
- Set the timing.
- Provide session reminders.
