# False Account — manual setup guide

**False Account** (`false_account`) helps you find out which visitors have created
more than one account on your site, and can block repeat offenders from making new
ones. It is aimed at sockpuppets and multi‑account abuse — the same person quietly
registering several accounts to stuff a vote, evade a ban, or spam.

It works by correlation, not by identity. On each non‑admin login the module drops a
long‑lived browser cookie (`fad`) containing a generated correlation id, and records
a small entity linking that id to the user account. When the same browser signs in to
further accounts, the shared correlation id groups them together. If three or more
accounts share one cookie — or a group has been marked as blocked — the account that
just logged in is blocked and shown a warning. Cron prunes correlation records older
than a year. Administrators review the grouped accounts through five bundled Views
(reached under People → **False Account Detector**), which is why the module depends
on the **Views Aggregator** module to do the grouping.

**Understand its scope and limits.** Detection is deliberately a *deterrent*, not an
authorization control. The correlation cookie is stored on the visitor's browser, so
someone who clears cookies, blocks them, or edits the cookie is not correlated and
evades detection. Treat False
Account as one layer in a defence‑in‑depth setup — pair it with CAPTCHA and
registration controls — rather than as a hard barrier. User 1 and anyone holding the
`administer false account` permission are never tracked.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the Views
   Aggregator dependency) and enable it.
2. [Configuration](configuration/index.md) — the settings form and how to review and
   act on flagged account groups.

## Where it lives in the admin menu

Once enabled, the settings form sits at **`/admin/user/false_account/settings`**
(config route `false_account.settings`). The review reports live under **People →
False Account Detector**, with tabs for Default, Blocked, Whitelisted, and Search.
Both the settings form and the review/action screens require the **Administer false
account** permission — grant it only to trusted moderators.
