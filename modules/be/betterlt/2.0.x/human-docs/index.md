# Better Local Tasks — manual setup guide

**Better Local Tasks** (`better_local_tasks`, project **`betterlt`**) gives Drupal's
local task tabs — the *View / Edit / Delete / Revisions* strip Drupal renders on many
pages — a fancier presentation. In this 2.0 branch it turns that strip into a **fixed,
icon‑driven slide‑out panel** pinned to the left edge of the viewport: mostly tucked
off‑screen, sliding out on hover, with an SVG icon per tab type.

Under the hood it is purely a presentation layer. It overrides two templates
(`menu_local_tasks` and the local‑tasks block) and ships one CSS file, plus a small hook
that inspects each tab's route and adds a semantic class (`view`, `edit`, `delete`,
`revisions`, `translate`, `clone`, `devel`, `shortcuts`) that the CSS maps to an icon. The
tabs still point at the same routes and do the same thing — only their look changes.

The styling is applied **only on front‑end (non‑admin) routes**, and **only** for users
who have the core **Access contextual links** permission (typically editors and admins).
Anonymous visitors and admin‑theme pages keep Drupal's default tabs. There is nothing to
configure — enabling the module is the entire setup, and it works the moment it is on.

Because the effect is CSS and Twig, the one thing worth checking is that the fixed left
panel agrees with your theme's markup and does not collide with other fixed elements. It
takes effect where core renders the **Local Tasks block**, so a theme that prints tabs
outside that block wrapper will not get the fixed panel.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for this module — it has no settings form, no
permissions of its own, and adds nothing to the admin menu. You adjust the look, if you
want to, by overriding its CSS or templates in your own theme (see below).

## Where it lives in the admin menu

Nowhere — Better Local Tasks adds no admin page. It simply restyles the local task tabs
on front‑end pages for privileged users once enabled.

## How to use it and how to customise it

Enable the module and the slide‑out panel appears on non‑admin pages for anyone with the
*Access contextual links* permission. To change the look, override it in your theme:

- Add CSS targeting `.block-local-tasks-block .blt-tabs …` to reposition or recolour the
  panel (for example, to undo the fixed left placement).
- Override `menu-local-tasks.html.twig` or `block--local-tasks-block.html.twig` in your
  theme to change the markup.
- Supply your own icons by overriding the per‑task `background-image` rules.
