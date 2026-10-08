# Progressive Admin — manual setup guide

**Progressive Admin** (`progressive_admin`) — full name *Progressive Admin
Experience* — simplifies Drupal's administration interface by introducing
configurable **experience levels**. You pick a global level — *Newcomer*,
*Intermediate*, *Advanced*, or *Full* — and the module filters the admin
**Navigation** menu so users only see the links appropriate to that level, and
restricts access to admin routes beyond it.

The idea is progressive disclosure: a newcomer to Drupal isn't confronted with the
full firehose of admin options, while an advanced user can open everything up. It
is built on core's Navigation module and pairs naturally with a "home" dashboard
for less-experienced users.

Progressive Admin is an administration/UI feature — it changes what the admin
interface shows and reaches, governed by its own permission. It has no content
role and adds nothing to the front end.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core Navigation dependency.

Setup is a single choice — the default experience level — covered under "How to
use it" below.

## Where it lives in the admin menu

After enabling the module, its configuration page is at
`/admin/config/progressive_admin`.

## How to use it

1. Go to the module's configuration page at `/admin/config/progressive_admin`.
2. Choose the **Default experience level** — *Newcomer*, *Intermediate*,
   *Advanced*, or *Full* — and save. This is a single global setting that
   determines how much of the admin Navigation menu is shown and which admin
   routes are reachable.
3. Review the result by browsing the admin Navigation menu: at lower levels, the
   menu is trimmed to the links allowed for that level.

> **Tip:** The maintainers suggest pairing this with core's **Dashboard** module,
> so Newcomer and Intermediate users get a clear "home" page, and with the
> **Trash** module for safe content recovery while access stays progressive. The
> **Gin** admin theme also complements the simplified experience.
