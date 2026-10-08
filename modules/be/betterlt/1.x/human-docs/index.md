# Better Local Tasks — manual setup guide

**Better Local Tasks** (project `betterlt`, machine name `better_local_tasks`)
replaces the default rendering of Drupal's local task tabs — the *View / Edit /
Delete* style tab strip at the top of many pages — with a cleaner, more modern
UI. Core's rendering of these tabs is functional but plain, and gets awkward
when there are many tabs or on narrow screens; this module restyles that region
to look better and behave better.

It is purely a presentation layer over the existing local-task system: it
changes how the tabs look, not what they are or do. It has no dependencies, no
configuration, and no permissions of its own. Enabling it applies the new
styling site-wide (or in the admin theme, depending on where local tasks
appear).

One thing worth knowing when you install it: the **project short name is
`betterlt`** but the **module machine name is `better_local_tasks`** — that
distinction matters when you enable it with Drush. Because the module is a
restyle, the main thing to check afterwards is that its styling agrees with
your theme's markup; a restyle built around one theme can look odd in another.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (note the machine name differs from the project name).

## How to use it

There is nothing to configure. Once enabled, the local-task tabs across your
site render with the module's refined style. Visit any page that shows tabs —
for example a node with **View / Edit / Delete** tabs — and confirm the new
styling looks right against your theme. If it clashes, that is a theming
adjustment rather than a module setting.
