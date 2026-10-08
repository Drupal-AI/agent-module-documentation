# Colorbox Load — manual setup guide

**Colorbox Load** (`colorbox_load`) makes ordinary Drupal links open their target
page inside a Colorbox lightbox, loaded over AJAX, instead of navigating away from
the current page. Click a teaser title, a menu link or a "view details" link and,
instead of a full page change, the destination page appears in an overlay on top of
what you were already looking at.

Under the hood the module is a small bridge between two other projects: the
**Colorbox** library integration and **NG Lightbox**. NG Lightbox owns the list of
"which paths should open in a lightbox"; Colorbox Load simply contributes an extra
*renderer* — labelled **Colorbox** — to NG Lightbox's settings, so the overlay is
drawn by the Colorbox library rather than by core's plain modal. Because of that, it
depends on both `colorbox` and `ng_lightbox`, and it has no settings form,
permissions, plugins or Drush commands of its own.

The module has almost nothing to switch on: when you install it, it automatically
sets NG Lightbox's renderer to **Colorbox** for you. What it does *not* do is decide
which links get the treatment — that is NG Lightbox's *Paths* list, which starts
empty, so nothing is lightboxed until you add at least one path pattern. If you want
to lightbox markup that is already on the page (rather than a page you navigate to),
the project points you at the separate `colorbox_inline` module instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Colorbox Load and its two
   dependencies with Composer and enable them.
2. [Configuration](configuration/index.md) — choose the Colorbox renderer and list
   the paths that should open in a lightbox (all on NG Lightbox's settings form).

## Where it lives in the admin menu

Colorbox Load has no page of its own. Everything you configure lives on NG Lightbox's
settings form at **Configuration → Media → NG Lightbox**
(`/admin/config/media/ng-lightbox`), where installing this module adds **Colorbox** as
a *Renderer* choice.
