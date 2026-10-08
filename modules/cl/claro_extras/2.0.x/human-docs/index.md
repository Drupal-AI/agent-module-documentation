# Claro Extras — manual setup guide

**Claro Extras** (`claro_extras`) adds a handful of **administrative UX tweaks for
the Claro admin theme**. It is a small quality-of-life module for teams whose admin
theme is Claro, addressing a few rough edges in the node editing experience.

It provides three things, each of which you can turn on or off:

- **Node meta block as vertical tabs.** Move the node "meta" block (author,
  published status, and similar) into **vertical tabs beneath the main node form**,
  and choose **which content types** this applies to.
- **Node-edit breadcrumb fix.** Remove the misleading `node` breadcrumb link that
  Claro shows when editing a node.
- **Enhanced Paragraph titles.** Make Paragraph titles more prominent and readable
  in the main node form.

The module has no other dependencies. It is purely an admin-experience change with
**no front-end effect**, and it is safe to enable site-wide: the vertical-tabs and
Paragraph enhancements only apply when the active **admin theme is actually
Claro**. Unlike most modules in this set, Claro Extras does have a real settings
form, so it needs a little configuration to get exactly the behaviour you want.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, option by option.

## Where it lives in the admin menu

Its settings form sits at **Appearance → Settings → Claro Extras**
(`/admin/appearance/settings/claro_extras`), and is also linked from the theme
settings. The settings page requires the **Access administration pages**
permission.
