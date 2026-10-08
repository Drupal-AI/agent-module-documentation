<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inactive Users lists (and acts on) users who have not logged in for a long period.

---

Inactive Users **detects and acts on dormant accounts** — it identifies users who haven't logged in for a
configured period (e.g. 6 months), can notify them by email ("Your account will be deleted in 7 days if no login
occurs."), and can block/cancel long-inactive accounts. It depends on core User.

Use it for account hygiene. This is a **security-positive** feature: dormant accounts are a common attack surface
(forgotten, weak-password, or shared accounts), and pruning/blocking them reduces that risk. Handle it carefully
because the deletion side is **destructive**: configure a sensible inactivity threshold and email grace period,
**exempt admin/service/system accounts** (and roles that should never be auto-cancelled), and decide between
block-vs-delete deliberately (deletion removes the user and may affect authored content). It runs on cron and is
gated for administrators. Configure the inactivity policy.

---

- Detect users inactive for a period.
- Warn them by email before action.
- Block/delete dormant accounts.
- Depend on core User.
- Serve account hygiene/security.
- BE security-positive (prune the attack surface).
- PERFORM destructive deletion (configure carefully).
- Set a sensible threshold + email grace period.
- EXEMPT admin/service/system accounts + protected roles.
- Choose block-vs-delete deliberately (deletion affects authored content).
- Run on cron, gated for admins.
- Configure the inactivity policy.
- Handle inactive users.
- Prune accounts.
- Configure the policy.
- Warn users.
- Handle the accounts.
- Block dormant users.
- Exempt admins.
- Provide inactive-account handling.
