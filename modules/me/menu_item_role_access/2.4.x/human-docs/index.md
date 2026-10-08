# Menu Item Role Access — manual setup guide

**Menu Item Role Access** (`menu_item_role_access`) adds a "visible to roles"
setting to each menu link, so a link only appears for users in the roles you
choose. You can build a single navigation menu that adapts per role — showing an
"Admin dashboard" link only to administrators, a "Members area" only to
authenticated users, or "Editor tools" only to content editors — instead of
maintaining separate menus for each audience.

The module works as soon as you enable it: it adds a roles checkboxes field to
every menu link's edit form. Pick one or more roles on a link to restrict it;
**leave the field empty and the link shows to everyone**, exactly as before. When
roles are selected, a user sees the link only if they hold at least one of them.
It depends on core's **Custom Menu Links** (`menu_link_content`) and **Menu UI**
(`menu_ui`) modules, which Drupal enables automatically.

One important caveat: this is menu-link **visibility, not page security**. It
controls whether a link is *displayed*, not whether the destination page can be
reached — Drupal's normal route permissions still guard the page itself. There is
also a small settings form for two behavior options (whether to ignore the
target's own access check, and how parent-to-child inheritance works).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per-link roles field, the two
   behavior settings, and the permissions.

## Where it lives in the admin menu

Two places. The per-link roles field appears directly on every menu link's
**add/edit** form under **Structure → Menus** (for example
`/admin/structure/menu/item/{id}/edit`). The module's own behavior settings form
sits at **Configuration → System → Menu Item Role Access Behaviour**
(`/admin/config/menu-item-role-access`).

## How to use it

Edit any menu link (Structure → Menus → edit a link). You'll see a new **roles**
field rendered as checkboxes. Tick the roles that should see the link and save.
Leave every box unticked to keep the link visible to everyone. That's the whole
day-to-day workflow — the settings form and permissions below are only for tuning
the behavior and delegating who may edit the field.
