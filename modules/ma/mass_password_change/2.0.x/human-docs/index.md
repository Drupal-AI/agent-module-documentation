# Mass Password Change — manual setup guide

**Mass Password Change** (`mass_password_change`) resets or changes the passwords
of **many accounts at once**, straight from the People administration screen. It is
primarily an **incident‑response tool**: after a credential breach — a leaked
database, a compromised administrator account, a discovered backdoor — the correct
response is to invalidate every password, and doing that one account at a time is
not an option on a site with thousands of users. It also covers planned cases: a
migration from a system whose password hashes cannot be carried over, a policy
change requiring everyone to re‑set, or decommissioning a shared account.

It plugs into the standard **People** page (`admin/people`) and into **Views Bulk
Operations (VBO)**, offering two actions:

- **Reset password** — issue a one‑time login link so each user sets a new password.
- **Change password** — change the password directly.

The module deliberately **will not change the password of user 1** (the primary
administrator, `uid=1`), which avoids the worst self‑lockout.

> **This is among the most destructive capabilities a site can expose.** A mass
> reset locks out every affected user simultaneously and cannot be undone. It is
> gated by the **`administer users`** permission, which is the appropriate control
> — keep that permission tightly held. Plan three things before running it: (1)
> **Notification** — decide whether affected users are emailed a reset link or
> simply find their password stops working, and confirm your site's mail actually
> delivers at that volume *before* you run it. (2) **Scope** — a reset that sweeps
> in service accounts, API users, or your own administrator can lock out the
> operator along with the attacker; select carefully. (3) **Sessions** — changing a
> password does not necessarily end existing sessions, so if the concern is an
> active intruder, invalidating sessions is a separate, deliberate step.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** — the module adds bulk actions to existing admin
screens, described in "How to use it" below.

## Where it lives in the admin menu

Mass Password Change adds no configuration page. Its actions appear as bulk
operations on **People** (`admin/people`) and in any **Views Bulk Operations**
view you configure.

## How to use it

1. Go to **People** (`admin/people`) as a user with the **`administer users`**
   permission.
2. Select the accounts you want to affect. **Review the selection carefully** — do
   not include service/API accounts or your own operator account unless you mean
   to. (User 1's password is protected and will not be changed.)
3. Choose the operation from the actions drop‑down: **Reset password** (sends a
   one‑time login link) or **Change password**.
4. Apply the action and confirm. For very large sites, prefer a **Views Bulk
   Operations** view so the work is queued/batched rather than run in a single
   request.
5. Afterwards, verify mail is being delivered (for the reset‑link route) and, if
   you are responding to an active intruder, follow up with session invalidation
   separately.
