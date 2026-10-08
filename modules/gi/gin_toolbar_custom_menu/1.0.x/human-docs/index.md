# Gin Toolbar Custom Menu — manual setup guide

**Gin Toolbar Custom Menu** (`gin_toolbar_custom_menu`) lets you replace the Gin
admin toolbar's menu with a menu of your choosing — and do it **per user role**. So
content editors can see a slim, curated "content" menu in the toolbar while
developers keep the full administration menu, all from the same site.

It works by extending the Gin Toolbar (part of the Gin admin theme). On its settings
page you build one or more **rules**. Each rule picks a menu (any menu from
**Structure → Menus**, such as *Main navigation* or a custom one you create),
assigns it to a set of roles, and can exclude other roles, set per‑item toolbar
icons, and control whether the standard administration menu is still shown. When a
user loads an admin page, the module matches their roles against your rules and, on a
match, swaps the toolbar's admin menu for the rule's menu.

A global option lets you keep the original administration menu alongside the custom
one, and each rule can override that. The module adds one permission for reaching
its settings form; the actual users who should see a custom toolbar must also have
core's "Use toolbar" permission.

It requires the Toolbar and Gin Toolbar modules and the Gin theme. It adds no
plugins or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Gin Toolbar.
2. [Configuration](configuration/index.md) — build per‑role rules, set icons and
   admin‑menu visibility, and grant the right permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Gin Toolbar Custom Menu**
(`/admin/config/system/gin-toolbar-custom-menu`).

## How to use it

Create (or reuse) a menu under **Structure → Menus**, then add a rule on the
settings page mapping that menu to the roles who should see it. Make sure those roles
also have core's **Use toolbar** permission. The step‑by‑step is in
[Configuration](configuration/index.md).
