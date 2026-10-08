# Inactive Users — manual setup guide

**Inactive Users** (`inactive_users`) detects and acts on dormant accounts. It
finds users who have not logged in for a configured period (for example six
months), warns them by email that their account is due to be removed ("Your account
will be deleted in 7 days if no login occurs."), and — if nobody responds — can
block or delete the account. It depends only on core's User module and runs on
cron.

This is a **security‑positive** tool for account hygiene. Dormant accounts are a
classic attack surface: forgotten logins, weak or reused passwords, and shared
credentials tend to accumulate on any long‑lived site, and pruning or blocking them
shrinks that risk. Used deliberately, it keeps your user list lean and safer.

That said, the deletion side is **destructive and effectively irreversible**, so
configure it carefully before turning it on. Set a sensible inactivity threshold and
a real email grace period so people have a chance to log back in; **exempt admin,
service, and system accounts** (and any roles that must never be auto‑cancelled);
and decide deliberately between *blocking* and *deleting*, remembering that deleting
a user removes the account and can affect content that user authored. Treat this as
an administrator‑only tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the inactivity policy, the warning
   email and grace period, the exemptions, and the block‑vs‑delete choice.

## Where it lives in the admin menu

Once enabled, you set the inactivity policy on the module's settings form under
**Configuration**. The actions run on cron, so make sure your site's cron is
scheduled. Access to the configuration is gated for administrators.
