# Gin Moderation Sidebar — manual setup guide

**Gin Moderation Sidebar** (`gin_moderation_sidebar`) is a tiny CSS bridge that makes
the **Moderation Sidebar** module's workflow tab look right when the **Gin** admin
theme (via Gin Toolbar) is active. On its own, the floating "Tasks" moderation tab
that Moderation Sidebar adds can look unstyled or misplaced under Gin; this module
supplies the small amount of styling needed to make it fit Gin's spacing and colours.

There is almost no logic here — the module just attaches a stylesheet and adds a body
class when Gin is the active admin theme. A single setting lets you pick between two
looks for the tab: **Default** and **High contrast**. If Gin is not the active admin
theme, the module quietly does nothing.

It works as soon as you enable it (using the Default style), and the one setting is
the only thing you might want to change. It has no permissions, services, plugins, or
Drush commands of its own, and it **hard-depends on both Moderation Sidebar and Gin
Toolbar** — so it is only useful on a site that already uses those two together.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with its two dependencies).
2. [Configuration](configuration/index.md) — the single tab-style setting.

## Where it lives in the admin menu

The one settings form is at **Configuration → User Interface → Gin Moderation
Sidebar** (`/admin/config/user-interface/gin-moderation-sidebar`), guarded by the
**Administer site configuration** permission.
