# Modules Info — manual setup guide

**Modules Info** (`modules_info`) provides a **block** that displays a table of your
site's modules and their information. It is aimed at Drupalers, communities, and
companies who want to publish a modules listing — for example on an internal or
public page — complete with links to each module's **usage**, **releases**,
**issues**, **bugs**, and **Drupal.org** project page.

Rather than a static list, the modules are stored as **content entities** that you
manage on a **Content → Modules** tab. When you add a module its data is fetched
immediately, and it is kept up to date afterwards by editing or by cron. You can
reorder entries by dragging, toggle a module's visibility in the block via an AJAX
status link, and switch off individual block columns from the settings page. There is
optional simple CSS styling you can attach or disable, and all labels are
translatable.

The module provides its own permissions and has no dependencies.

> The module and version list is effectively **fingerprinting data** about your site.
> Gate the block and its management to trusted users and think carefully before
> exposing it publicly.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

The module's small settings (block columns and CSS) are described below, folded into
this overview.

## Where it lives in the admin menu

- **Manage entries** — add and reorder module entries on the **Content → Modules** tab.
- **Place the block** — add the Modules Info block to a region at **Structure → Block
  layout** (`/admin/structure/block`).
- **Settings** — the module's settings page lets you disable individual block columns
  and attach or disable the bundled CSS.

## How to use it

1. After installing (see [Installation](installation/index.md)), go to **Content →
   Modules** and add the modules you want to list. Their data (links to usage,
   releases, issues, bugs, and the project page) is populated immediately and refreshed
   on cron.
2. Drag entries to reorder them, and use the AJAX **Status** link to switch any module
   on or off in the block.
3. Place the **Modules Info** block in a region via **Structure → Block layout**.
4. On the settings page, disable any block columns you don't want and choose whether to
   use the bundled CSS.
