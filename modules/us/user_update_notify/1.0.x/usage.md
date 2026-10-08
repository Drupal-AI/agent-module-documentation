<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Update Notify emails a notification to a specific email address when a user is updated.

---

User Update Notify **emails a notification when a user account is updated** — sending an alert to a
configured address whenever an account changes, so administrators are informed of account modifications. It
depends on the Token module, provides its own permissions, in its package.

Use it to be alerted to account changes. This is a **security-monitoring-positive** feature — being notified
when accounts are modified (email address, roles, status) helps detect unauthorized or unexpected account
changes (account-takeover indicators). Two considerations: the notification email may include **account detail
(PII)**, so send it to a **trusted admin address** (and over a trustworthy mail path), and it depends on the
configured recipient being correct. It has no access-control role beyond its permission. Configure the
notification recipient and events.

---

- Email on user account update.
- Alert a configured address.
- Inform admins of account changes.
- Depend on the Token module.
- Provide its own permissions.
- Detect unauthorized changes.
- Help spot account-takeover indicators.
- Send to a trusted admin address (PII).
- Use a trustworthy mail path.
- Have no access-control role beyond permission.
- Configure the recipient/events.
- Handle update notifications.
- Notify on changes.
- Configure notifications.
- Alert on updates.
- Monitor accounts.
- Handle the alerts.
- Email admins.
- Set the recipient.
- Provide account-change alerts.
