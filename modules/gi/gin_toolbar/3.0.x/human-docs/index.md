# Gin Toolbar — manual setup guide

**Gin Toolbar** (`gin_toolbar`) is a small companion module for the **Gin** admin
theme. Its one job is to bring Gin's styled administration toolbar out of the
back end and onto the front end of your site, so that logged‑in editors see the
same Gin‑themed toolbar everywhere — not just while they are on admin pages.

Why is a separate module needed? Admin themes in Drupal don't fully control the
toolbar that appears on front‑end (non‑admin) pages, so Gin can't restyle that
toolbar on its own. Gin Toolbar fills the gap: it overrides the relevant toolbar
and navigation templates, attaches Gin's CSS and JavaScript on front‑end pages,
and reads the active Gin theme settings — accent color, focus color, dark mode,
high‑contrast mode, and toolbar variant — exposing them so the front‑end toolbar
matches the back end exactly. It also supports Drupal's newer Navigation module
and the experimental "new" navigation, and adds active‑trail highlighting to the
administration tray.

The module **works purely through theme overrides and library attachments** —
there is nothing to configure. It only activates when **Gin** (or a Gin subtheme)
is set as the admin or default theme and the user has permission to see the
toolbar, so it stays completely inert for anonymous visitors and on non‑Gin
sites. Every appearance option — accent, dark mode, toolbar variant, and the rest
— comes from the **Gin theme's own settings**, not from this module. It requires
Drupal 11.2 and, as its whole reason for existing, the **Gin** theme
(`drupal/gin`); the toolbar does nothing without it.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — the theme hooks, overridden
templates, and attached libraries — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (alongside the Gin
   theme) with Composer and enable it.

## Where it lives in the admin menu

Gin Toolbar has **no configuration page** (`configure` is null), no permissions,
and no admin menu items of its own. Everything you might want to change lives in
the Gin theme's settings at **Appearance → Settings → Gin**
(`/admin/appearance/settings/gin`) — accent color, dark mode, high‑contrast mode,
and the toolbar variant. Gin Toolbar simply reads those and applies them to the
front‑end toolbar.

## How to use it

1. Make sure the **Gin** theme is installed and set as your **administration
   theme** (and, if you want the styled toolbar for editors on the front end,
   confirm they have permission to see the toolbar).
2. Install and enable Gin Toolbar (see [Installation](installation/index.md)).
3. That's it — log in as an editor and browse to a front‑end page. The Gin‑styled
   toolbar now appears there too, matching the colors, dark/high‑contrast mode,
   and toolbar variant you chose in the Gin theme settings.
