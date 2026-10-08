<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Deactivation Date provides a deactivation date for user accounts with cron integration.

---

User Deactivation Date lets you set a **deactivation date on a user account** — a cron job blocks the
account when that date is reached, so temporary/contractor/time-limited accounts are disabled automatically
instead of relying on someone remembering to block them. It depends on core Datetime and User.

Use it to auto-expire accounts. This is a **security/account-lifecycle-positive** feature — automatically
blocking accounts at a set date reduces the risk of stale, forgotten accounts remaining active (a common
access-hygiene gap). Note it depends on **cron running reliably** (if cron is broken, accounts won't be blocked
on time). It sets the account's blocked status; who can set the date follows user-edit access. Configure the
deactivation date per account.

---

- Set a deactivation date per account.
- Block accounts via cron on the date.
- Auto-expire temporary accounts.
- Depend on core Datetime and User.
- Reduce stale-account risk.
- Disable accounts automatically.
- Improve access hygiene.
- Rely on cron running reliably.
- Set the account's blocked status.
- Follow user-edit access for setting the date.
- Have no other access-control role.
- Configure the deactivation date.
- Handle account deactivation.
- Expire accounts.
- Configure the date.
- Block accounts.
- Handle the lifecycle.
- Deactivate users.
- Set the date.
- Provide account expiry.
