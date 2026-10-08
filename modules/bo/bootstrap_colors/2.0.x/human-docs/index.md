# Bootstrap Colors — manual setup guide

**Bootstrap Colors** (`bootstrap_colors`) lets you apply colors to Bootstrap
**Barrio**‑based themes using Material Design color concepts. You configure a
color palette that maps onto the theme's Bootstrap variables, so a Barrio
subtheme can be recolored **without writing SCSS**. It lives in the *Bootstrap*
package and provides its own permission.

It is a theming/administration feature that affects appearance only — it has no
content or access role beyond its permission. Use it to recolor a Barrio‑based
Bootstrap theme by configuring the palette and mapping colors to the Bootstrap
variables the theme uses.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module provides its own permission, which you grant at **People →
Permissions** (`/admin/people/permissions`) to the roles that should manage
theme colors. Its work is configuring the color palette that maps onto the
Barrio theme's Bootstrap variables — a theming/appearance task. Look for its
palette settings link on the Extend page after enabling it, or in the module's
`README`, since this niche module's docs do not pin an exact admin path.

## How to use it

1. Use a **Bootstrap Barrio‑based theme** (or a Barrio subtheme).
2. Grant the module's permission to the appropriate role(s).
3. Configure the **color palette** — pick colors using the Material Design
   concepts it offers. Those colors are mapped onto the theme's Bootstrap
   variables, recoloring the theme without any SCSS editing.
