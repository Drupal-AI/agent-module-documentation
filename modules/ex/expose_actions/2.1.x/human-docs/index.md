# Expose actions as local actions — manual setup guide

**Expose actions as local actions** (`expose_actions`) takes Drupal's core
*Action* entities — the same reusable action plugins that Views Bulk Operations
and Rules use — and surfaces them as clickable **local action links** in the
admin UI. Instead of an action only being reachable programmatically or through a
bulk-operations view, a permitted user can run it directly on the entity where it
makes sense: while viewing that entity, a local action appears, and clicking it
runs the action through a confirmation form.

The module is deliberately lightweight. It adds no configuration page of its own —
you manage the underlying actions on Drupal's core **Actions** list, decide which
of them to expose, and then grant the matching per-action permission to the roles
that should be able to run each one. Each exposed action gets its own permission
named `access exposed action <id>`.

Treat the per-action permissions as powerful: exposing an action makes it a
one-click operation for everyone who holds its permission. Expose actions
deliberately — especially destructive ones such as delete or unpublish — and
grant each `access exposed action <id>` permission only to roles you trust to run
that action.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. You configure it entirely
through the core **Actions** list and the **Permissions** page, as described in
"How to use it" below.

## Where it lives in the admin menu

Expose actions has no admin page of its own. You work with it in two existing core
places:

- **Configuration → System → Actions** (`/admin/config/system/actions`) — review
  the available actions and create/configure new ones.
- **People → Permissions** (`/admin/people/permissions`) — grant each
  `access exposed action <id>` permission to the appropriate roles.

## How to use it

1. Go to **Configuration → System → Actions** and make sure the action you want to
   expose exists (create and configure one if needed).
2. Go to **People → Permissions** and grant the `access exposed action <id>`
   permission for that action to the roles that should be able to run it. Keep
   destructive actions restricted to trusted roles.
3. Make sure the **local actions block** is present in your theme/region for the
   pages where you view the relevant entities — the exposed action links render
   there.
4. A permitted user viewing a matching entity will now see the exposed action as a
   local action link. Clicking it opens a confirmation form; on confirm, the
   action runs on that entity.

Because an exposed action becomes a direct, one-click operation for the roles you
grant it to, review which actions you expose and grant each action's permission
only to trusted roles.
