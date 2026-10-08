# Domain Views Display — manual setup guide

**Domain Views Display** (`domain_views_display`) lets you override a Views
display with a *different* display on specific domains of a
[Domain](https://www.drupal.org/project/domain) (Domain Access) multi‑domain
site. The classic example: you have an RSS listing that serves both
`a.example.com` and `b.example.com`, and you want `b.example.com` to show a
tailored version. With this module you build a second display for `b.example.com`
and tell the original display to hand off to it on that domain — all inside the
one view.

It is offered as a simpler, more site‑builder‑friendly alternative to
domain‑specific configuration overrides. (Drupal's Domain Config UI does not yet
work with Views; if that ever changes, this module becomes largely obsolete.)
Everything is configured from within the Views UI itself — there is no separate
admin settings form.

It depends on core **Views** and the **Domain** module, and runs on Drupal 10.3
and 11. Two things are worth knowing before you rely on it: it is possible to set
up redirect *loops* (display A points to display B, which points back to A), so
map your overrides deliberately; and if you rename a display that another display
overrides, you will need to reconfigure the override. It is not covered by
Drupal's security advisory policy, and results always follow the view's own access
controls — the module adds no access role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views and Domain.

There is **no standalone configuration page** for this module — you configure it
per view, inside the Views UI, as described below.

## How to use it

1. Edit the view you want to vary by domain (**Structure → Views**).
2. In the display you are editing, look for the new **Domain overrides** field
   group in the center column.
3. Click the link next to **Override display**.
4. Choose which display to use for each configured domain.

Repeat for each display you want to redirect. Keep the mapping simple to avoid
accidental A→B→A loops, and remember to revisit the override if you later rename
one of the displays involved.
