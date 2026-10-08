<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Local Tasks (betterlt) — agent index

Restyles Drupal's **local task tabs** into a fixed, icon-driven slide-out panel on the left edge.
Version **2.0.x**. Core `^9.3 || ^10 || ^11`. No deps, no config, no permissions of its own, no config schema.

**Machine name `better_local_tasks`** (project `betterlt`). Purely a Twig/CSS presentation layer — same tabs, same routes, restyled. Enabling it is the entire setup.

Key facts to know before touching it:
- Applies **only on non-admin routes** and **only** for users with the `access contextual links` permission. Admin-theme pages and anonymous users keep core's default tabs.
- No `src/`, no services, no plugins, no Drush, no forms. It is three hooks + two template overrides + one CSS file.

- **[Theming / how it works](theming/local-tasks.md)** — the hooks, template overrides, library, per-task CSS classes and icons, and how to customise the look.
