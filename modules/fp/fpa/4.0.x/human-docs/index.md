# Fast Permissions Administration — manual setup guide

**Fast Permissions Administration** (`fpa`) replaces Drupal core's permissions
page (`/admin/people/permissions`) with an enhanced, filterable version, so
managing permissions on a site with many modules and roles stays fast and
usable.

Core renders every permission for every role in one enormous HTML table. On a
real site with dozens of modules and several roles, that becomes thousands of
rows and checkboxes that are slow to load and painful to scan. FPA takes over the
same route and re‑renders the identical permission grid with a **live,
client‑side filter box**, a per‑module list you can jump to, a role filter, and a
checked/not‑checked status filter — plus a togglable column that reveals each
permission's machine (system) name. You filter by typing `permission@module` —
for example `admin@system` matches permissions containing "admin" in modules
containing "system" — and because it all happens in the browser, there are no
page reloads.

Importantly, FPA is a **pure UI enhancement**: the underlying core form still
saves role permissions exactly as before, so there's nothing to migrate and no
change to how permissions are stored. It depends only on the `js_cookie` module
(used to remember your toggle preferences) and adds one small settings form and
one permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the optional settings form for
   hiding UI sections, and the permission that gates it.

## Where it lives in the admin menu

The enhanced page is the usual **People → Permissions**
(`/admin/people/permissions`) — FPA simply takes it over. Its own small settings
form is at **Configuration → People → Fast permissions administration settings**
(`/admin/config/people/fpa-settings`).

## How to use it

Just enable the module — the enhanced permissions page works immediately, no
configuration needed. On `/admin/people/permissions`, type in the filter box to
narrow the list instantly (using `permission@module` syntax), click a module in
the sidebar to jump to it, use the role and status filters to focus, and toggle
the machine‑name column when you need the system name of a permission. Your view
preferences are remembered between visits via a cookie.
