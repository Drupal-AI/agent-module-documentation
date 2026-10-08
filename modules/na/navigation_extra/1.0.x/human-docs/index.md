# Navigation Extra — manual setup guide

**Navigation Extra** (`navigation_extra`) builds on Drupal core's new left-sidebar
**Navigation** module, adding a set of configurable menu sections and blocks that core doesn't
provide out of the box. From one settings page you can add Content, Media, Taxonomy, Users,
Files, Blocks, Forms, Local Tasks and Tools sections to the sidebar, plus a Version indicator
— and switch each one on or off independently.

Each feature is a small plugin that contributes its own settings tab and injects its links
into the navigation menu. You can group links into hierarchical **collections** (with
top/bottom grouping and automatic hiding of empty ones), add "create new" links, show recent
content, surface role and people links, link the Media section to the Media Library, add
webform and contact-form links, and even override core's three-level menu-depth cap for deeper
trees. The **Version** feature can display the current site or app version (read from a file,
environment variable, provider or module) with per-environment colours — handy for telling
dev, staging and production apart at a glance.

Navigation Extra also ships three placeable blocks (local tasks, version indicator, and a
navigation menu override) and lets other modules declare their own navigation collections via
a hook. Everything is admin configuration behind a trusted permission — there are no
front-end-facing settings.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it
   alongside core Navigation.
2. [Configuration](configuration/index.md) — the settings page and each feature's options.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Navigation → Extra**
(`/admin/config/user-interface/navigation/extra`), gated by the **Administer site
configuration** permission. The module adds no permissions of its own. The three blocks are
placed the usual way, via **Structure → Block layout** or Layout Builder.
