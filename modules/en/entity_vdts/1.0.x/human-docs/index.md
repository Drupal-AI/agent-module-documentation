# Entity View Display Template Suggestions — manual setup guide

**Entity View Display Template Suggestions** (`entity_vdts`) is a theming
convenience for front-end developers. It adds Twig **template suggestions** that
are keyed on an entity's **view display configuration**, not just its bundle or
view mode. That lets you write one generic template and decide, per view display,
whether that display should use it — giving finer control than the standard
bundle/view-mode suggestions Drupal offers out of the box.

The idea is to have generic, view-mode-agnostic templates and switch them on or
off per display from the display configuration screen. In this release the module
provides a single, bare template suggestion — enough to target a template to a
specific view display when you want to.

It is a pure theming feature: it does not change content, does not touch access
control, and has no security surface. It has no module dependencies and no
central settings page — the one option it adds appears directly on each entity's
**Manage display** screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page**. The one setting this module adds lives
on each view display's **Manage display** screen, described below.

## How to use it

1. Enable the module.
2. Go to a view display configuration — for example **Structure → Content types →
   *(type)* → Manage display** (a URL such as
   `/admin/structure/types/manage/page/display`).
3. You will find a new option there that lets you enable a template suggestion
   for that display.
4. Add a matching Twig template to your theme to take advantage of the new
   suggestion (turn on Twig debugging to see the exact suggested filename Drupal
   is looking for).
