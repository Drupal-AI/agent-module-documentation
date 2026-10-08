# Views Exposed Form Layout (VEFL) — manual setup guide

**Views Exposed Form Layout** (`vefl`) gives you control over how a View's
**exposed form** is arranged. Normally, when you expose filters, sorts, and
actions on a View, they all render in a single flat row. VEFL adds a new exposed
form *style* that lets you drop each of those widgets into the **regions of a
layout** instead — so you can build a multi‑column filter bar, a compact toolbar,
or a responsive single‑column stack, all without writing any Twig or PHP.

You turn it on per View. On the View's **Exposed form** settings you choose
"Basic (with layout)" as the exposed form style, then pick a layout and assign
every exposed widget — each filter, plus actions like sort‑by, sort‑order, items
per page, submit, and reset — to one of that layout's regions. Any layout
registered with Drupal's Layout API works, including the layouts that come from
Display Suite and Panels, so you are not limited to a fixed set. The module also
ships one simple single‑column layout (`vefl_onecol`) to get you started, and the
resulting form is themed through a standard, overridable template if you want to
fine‑tune the markup per View.

Typical uses are arranging a catalog's filters into responsive columns, grouping
sort controls together, moving "Items per page" into a sidebar, or separating the
submit and reset buttons into their own regions. A bundled submodule,
**VEFL for Better Exposed Filters** (`vefl_bef`), brings the same
region‑placement capability to forms built with the Better Exposed Filters
module.

VEFL is a site‑builder / theming tool: it has no admin settings page of its own
and adds no permissions. It requires core's **Views** and **Layout Discovery**
modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the exposed‑form
plugin, option keys, template hook, and how to define custom layouts — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and enable the Better Exposed Filters submodule if you need it.

## Where it lives in the admin menu

VEFL has no menu entry of its own. You use it inside the Views UI — **Structure →
Views** (`/admin/structure/views`) — on the **Exposed form** section of any View
that has exposed filters.

## How to use it

Edit a View that has exposed filters. In the **Exposed form** section, set the
**Exposed form style** to **Basic (with layout)** and apply. Then open its
settings: pick a **layout**, and for each exposed widget choose which **region**
of that layout it should appear in. Save the View, and the exposed form now
renders through your chosen layout. If you use Better Exposed Filters, enable the
`vefl_bef` submodule to get the same option for BEF forms.
