<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Registration Notification emails chosen roles or explicit addresses when a user account is created, updated, or deleted, so a human learns about the event without watching the People screen.

---

Drupal notifies the *user* about their own account and tells nobody else. This module fills that gap for sites that need a person in the loop on registrations — to approve an account, welcome a new member, or track sign-ups. It hangs off the core user entity hooks (`hook_user_insert/update/delete`) and core `hook_mail`, with no service, plugin, cron, or Drush. A single settings form at `/admin/config/people/user_register_notify/settings` (permission `administer user_register_notify configuration`) drives one config object, `user_register_notify.settings`. You choose a recipient `type` (a role whose active members are mailed, an explicit comma-separated address list, or both), which `events` fire (create / update / delete), and a token-based subject and body per event; a per-event include/exclude role filter narrows which accounts trigger a mail, and uid 1 is always skipped. `token` is a dependency so message templates can carry account details, and the module adds one Organic Groups token. Optional `From`/`Reply-to` header overrides and per-send logging round it out. Requirements are core `user`, `token`, and core `^10.3 || ^11`; the newest release on the branch is **2.0.0-beta2** (no stable yet). Note that the module ships disabled (`type: disabled`, empty `events`) — nothing is sent until it is configured, and role targeting mails every active member of the chosen role.

---

- Notify administrators of every new registration.
- Alert a moderator to approve a pending account.
- Email a team when an account is deleted.
- Watch for a spam registration wave.
- Notify a membership secretary of sign-ups.
- Include account details in the mail via tokens.
- Target notifications at a specific role.
- Send to an explicit list of addresses.
- Track account edits (profile / role changes).
- Support an approval workflow.
- Welcome new members promptly.
- Notify only when a created account has (or lacks) a given role.
- Notify support of a cancelled account.
- Keep an audit-adjacent record by email.
- Alert when a privileged-role account is created.
- Override the From/Reply-to on notification mail.
- Log every notification for debugging.
- Add an Organic Groups membership list to the message.
- Notify several teams at once via a shared role.
- Customize the subject and body per event.
- Reduce time-to-approval for registrations.
- Send to both a role and a fixed inbox simultaneously.
