# Deactivate Inactive Users — manual setup guide

**Deactivate Inactive Users** (`deactivate_users`) automatically blocks user
accounts that haven't logged in for a configured number of days. It's an
account-hygiene security control: on each cron run it finds accounts that have
passed your inactivity threshold and blocks them (in Drupal terms, "blocked" means
the account can no longer log in), and it can notify users along the way.

The reasoning behind it is a standard security best practice — reflected in
control families such as NIST 800-53 — that accounts unused for a defined period
should be deactivated. Dormant accounts are a common target: they tend to have
old or weak credentials and nobody watching them, so disabling them shrinks your
attack surface. The action is fully reversible — an administrator can unblock an
account at any time — and the module includes a **grace period** so that a
freshly unblocked user isn't immediately re-blocked on the next cron run.

The module works on a simple sum: the total time before an account is actually
blocked is the **Inactivity Limit** plus the **Grace Period**. For example, many
sites set 85 days plus 5 days to reach a required 90-day policy. It depends on the
**Token** module (used in the notification email templates), and it's configured
under **Configuration → Users → Deactivate users**. Its admin routes are gated by
the **Administer site configuration** permission. It supports Drupal 9, 10, and
11, is actively maintained, and is covered by Drupal's security advisory policy.

Because this module blocks real accounts, plan its configuration carefully before
enabling it in production — in particular, watch out for service or system
accounts you don't want blocked.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Token dependency.
2. [Configuration](configuration/index.md) — the inactivity limit, grace period,
   and email templates.

## Where it lives in the admin menu

The settings form is at **Configuration → Users → Deactivate users**
(config route `deactivate_users.admin_settings`), available to users with the
**Administer site configuration** permission.
