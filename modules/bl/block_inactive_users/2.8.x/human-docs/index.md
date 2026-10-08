# Block Inactive Users — manual setup guide

**Block Inactive Users** (`block_inactive_users`) keeps dormant accounts from
piling up. It has two jobs: on every cron run it automatically **blocks** users
who have not been active for a configured number of months (optionally emailing
them a reactivation link first), and it provides a separate one‑off **Cancel
Users** tool for bulk‑cancelling stale accounts by role, status and whitelist
rules.

The automatic side measures inactivity in **months** against each user's last
access time. When someone crosses the threshold they are blocked — with the
administrator (uid 1) and any roles you exclude always skipped. You can also send
an advance **warning email** a set number of days beforehand (each user is warned
only once, and logging in clears the warning), and blocked users can follow a
confirmed **reactivation link** to request re‑activation of their account. All the
email templates support tokens, including the module's own `[activation-link]` and
`[days-until-blocked]`.

The **Cancel Users** tool is a heavier, deliberate action: it runs Drupal core's
`user_cancel()` in bulk over accounts that match your rules — idle time, included
roles and statuses — while honouring username and email whitelists so protected
accounts are never touched. You choose the cancellation method (block, block and
unpublish content, reassign content, or delete) and whether to send the standard
confirmation email, then confirm on a summary step before anything happens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the auto‑block settings, the warning
   emails, and the bulk Cancel Users tool, field by field.

## Where it lives in the admin menu

The main settings form is at **Configuration → People → Block Inactive Users**
(`/admin/config/people/block_inactive_users`), and the bulk tool is at
**Configuration → People → Block Inactive Users → Cancel Users**
(`/admin/config/people/block_inactive_users/cancel_users`). Both are gated by the
core **Administer site configuration** permission.

> **A note on permissions.** The module also declares a restricted permission,
> **Administer block_inactive_users configuration**, but the settings and cancel
> forms actually require the core **Administer site configuration** permission —
> so grant *that* to give a role access. The public reactivation link is reachable
> with **Access content**, since it is meant to be followed by a blocked user from
> their email.

## How to use it

1. Enable the module.
2. On the main settings form, set the idle time in months and configure the block
   (and optional warning) emails. Blocking then happens automatically on cron —
   or you can trigger it immediately with the form's "Disable inactive users"
   button.
3. For a one‑time cleanup, use the **Cancel Users** tool: set your rules and
   whitelists, choose a cancellation method, and confirm.

See [Configuration](configuration/index.md) for each setting.
