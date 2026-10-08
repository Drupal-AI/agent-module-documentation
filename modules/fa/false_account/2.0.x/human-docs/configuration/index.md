# Configuration

False Account starts working the moment it is enabled — it begins correlating logins
straight away. This page covers the small settings form and, more importantly, how to
review and act on the account groups it flags.

## Open the settings form

1. Log in as a user with the **Administer false account** permission.
2. Go to **`/admin/user/false_account/settings`** (config route
   `false_account.settings`).

The settings form lets you configure the **redirect target** — where a visitor is
sent after the module acts on their login. Set it to a page that explains what has
happened, then save.

## How detection works (so the reports make sense)

- On each login by a normal (non‑admin, non‑user‑1) account, the module either drops
  a new correlation cookie and records the account under a fresh correlation id, or —
  if the browser already carries the cookie — adds the new account to the existing
  group.
- When a group reaches **three or more** accounts sharing one browser, or the group
  has been marked **blocked**, the just‑logged‑in account is blocked and a warning is
  shown.
- Cron removes correlation records older than one year.

## Reviewing flagged groups

The reports live under **People → False Account Detector**. The list is filtered so
that only *duplicate* correlation ids appear — unique, non‑suspicious browsers are
hidden — and the counts are produced by Views Aggregator. The tabs are:

- **Default** — all correlated account groups.
- **Blocked** — only the groups that have been blocked.
- **Whitelisted** — groups you have marked trusted.
- **Search** — find correlated accounts by user.

Administrators also see a per‑user **False Account** panel on a user's profile.

## Acting on a group

From the reports you change a whole group's status at once. The three actions are:

| Action | Effect |
|--------|--------|
| **Activate** (status 0) | Return every account in the group to the normal, active state — use this to undo a mistaken block. |
| **Whitelist** (status 1) | Mark the group trusted so its members are never auto‑blocked (activates them and flags them as safe). |
| **Block** (status 2) | Block every account in the group of suspected false accounts. |

## A note on trust and safety

- Detection is **evadable by design**: the correlation cookie lives on the visitor's
  browser, so clearing, blocking, or editing it defeats correlation. Use False
  Account as a deterrent alongside CAPTCHA and registration controls, not as your only
  line of defence.

## Save

Save the settings form after setting the redirect target. Review actions on the
report screens take effect immediately for the whole group.
