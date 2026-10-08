# Tailwind Grid — manual setup guide

**Tailwind Grid** (`tailwind_grid`) is a **Views style plugin** that lays out your
View's results in a responsive grid built from **Tailwind CSS** grid classes.
Instead of writing custom Twig templates or CSS to arrange teasers, cards, or other
rows into columns, you pick the Tailwind Grid style on a View and configure how many
columns you want at each screen size — and the module outputs the appropriate
Tailwind grid utility classes for you.

It is aimed at sites using a **Tailwind-based theme**: because the layout is
expressed entirely as Tailwind classes, those classes need to be available in your
theme's compiled CSS for the grid to actually render. The module only affects
presentation — the results shown still respect the View's own access rules, and it
has no access-control role of its own. It lives in the Views package and needs no
other modules.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the Tailwind Grid style on a
   View and set columns per breakpoint.

## Where it lives in the admin menu

Tailwind Grid provides a settings configuration (`tailwind_grid.settings`) for its
defaults, but the main place you work with it is inside the **Views** UI: you select
the *Tailwind Grid* format on a View display and configure it there. See
[Configuration](configuration/index.md).
