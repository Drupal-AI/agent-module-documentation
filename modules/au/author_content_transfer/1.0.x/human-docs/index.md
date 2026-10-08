# Author Content Ownership Transfer Workflow — manual setup guide

**Author Content Ownership Transfer Workflow** (`author_content_transfer`)
reassigns node authorship away from inactive users and onto a target account —
automatically on cron, and manually from a bulk dashboard. Where
[Author Bulk Assignment](../../author_bulk_assignment/2.0.x/human-docs/index.md)
is a one-off action you trigger by hand, this module runs an ongoing *policy*:
you define who counts as inactive and where their content should go, and it keeps
enforcing that on every cron run.

Under the hood an ownership-transfer service finds content owned by users the
module considers inactive (per your settings) and moves those nodes to the
configured destination user. A cron hook runs the transfer on schedule, so
content never sits owned by a disabled or abandoned account for long. Alongside
the automation you get a bulk dashboard for running an ad-hoc reassignment on
demand, and an analytics dashboard for reviewing what was transferred and when.

This is a bulk write to node ownership, so treat it as an administrative
operation. All three of its screens sit behind a single permission,
`administer author content transfer`, which should be scoped tightly — anyone
with it can mass-reassign authorship across the site. The module makes no
outbound requests and stores no secrets; its only real risk surface is the
ownership change itself, which is admin-gated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the inactivity policy, target user,
   dashboards, and cron behaviour.

## Where it lives in the admin menu

The module adds three admin pages under Configuration:

- **Settings** — `/admin/config/ownership-transfer` — define the inactivity
  policy and the destination account.
- **Bulk dashboard** — `/admin/config/ownership-transfer-bulk` — run an ad-hoc
  bulk transfer now.
- **Analytics dashboard** — `/admin/config/ownership-transfer-dashboard` —
  review transfer activity and preview counts.

All three require the `administer author content transfer` permission.
