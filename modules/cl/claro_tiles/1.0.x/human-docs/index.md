# Claro Tiles — manual setup guide

**Claro Tiles** (`claro_tiles`) is a small styling enhancement for Drupal's
**Claro** admin theme. It adds custom CSS that presents certain admin listings and
action links as a tile-based, card-like layout instead of the default line-based
one, giving the administration interface a more visual, touch-friendly feel and,
its author argues, better readability.

It is purely a look-and-feel change. The module carries no content model and no
access-control role of its own — enabling it simply layers its CSS onto the admin
theme. It supports Drupal 10 and 11.

One requirement is important: Claro Tiles only does anything when the **Claro**
admin theme is enabled, since its styling targets Claro specifically. If your site
uses a different admin theme, the module will have no visible effect.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. The
tile styling applies automatically once the module is enabled and Claro is your
admin theme.

## How to use it

There is nothing to configure. Confirm that **Claro** is set as your
administration theme (under **Appearance**), then enable the module. Reload any
admin listing page and the action links and listings styled by the module should
appear as tiles rather than plain lines.
