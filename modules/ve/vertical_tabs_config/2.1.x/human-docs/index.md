# Vertical Tabs Config — manual setup guide

**Vertical Tabs Config** (`vertical_tabs_config`) cleans up the node add/edit form
by letting you **hide** the vertical tabs (Authoring information, Promotion
options, Menu settings, Revision information, and so on) and **reorder** them —
per content type, and optionally per role. It's a quick way to simplify the
editing experience for non-technical editors without writing a custom
`hook_form_alter()`.

The module has two features, on two admin screens. **Visibility** lets you tick,
per content type, which tabs to hide — either for everyone or only for selected
roles (so you can, for example, hide the authoring-information tab from an
"editor" role while admins keep it). **Order** lets you set a weight for each tab
so the most-used ones float to the top. The visibility rules are stored in a
custom database table (so they are **not** captured by config export/import),
while the tab order is stored in normal configuration.

It affects **only node add/edit forms**. It has no dependencies, no permission of
its own (both screens use the core *Administer site configuration* permission),
and no submodules. Note that the Metatag tab is deliberately excluded from
reordering because it forces itself to the top.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — hide tabs per content type and role,
   and set the tab order.

## Where it lives in the admin menu

Both screens sit under **Configuration → User interface → Vertical Tabs Config**
(`/admin/config/user-interface/vertical_tabs_config`) — one for **Visibility**
and one for **Order**.
