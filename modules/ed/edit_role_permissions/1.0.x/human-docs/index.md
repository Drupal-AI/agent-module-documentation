# Edit Role Permissions — manual setup guide

**Edit Role Permissions** (`edit_role_permissions`) is a tiny admin‑convenience
module. On the roles admin list, the default action beside each role is normally
**"Edit"**, which opens the role's edit form — where you can change its label or
machine name. But most of the time, when you click a role you actually want to edit
its **permissions**, not rename it. This module changes that default operation link
from **"Edit"** to **"Edit permissions"**, so the primary action jumps straight to
the role's permissions page.

It's a one‑trick module and it works the moment you enable it — there is **nothing
to configure**. It depends only on the core **User** module.

Importantly, it is **access‑neutral**: it grants no new capability to anyone. All
it does is alter an operation link (via `hook_entity_operation_alter()`); the
permissions page it links to is still governed by core's own **"Administer
permissions"** access. Users who couldn't manage permissions before still can't —
the link simply saves a click for those who can.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings. Its single
behavior is described below.

## Where it lives in the admin menu

Everything happens on the roles list at **People → Roles**
(`/admin/people/roles`). After enabling the module, the default operation link for
each role reads **"Edit permissions"** and takes you to that role's permissions
page (still gated by core's **Administer permissions**), rather than to the role's
edit form. That's the whole feature.
