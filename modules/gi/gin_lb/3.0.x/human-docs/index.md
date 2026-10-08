# Gin Layout Builder — manual setup guide

**Gin Layout Builder** (`gin_lb`) re-skins Drupal's Layout Builder editing interface —
along with the off-canvas dialogs and the Media Library modal it opens — with the
[Gin](https://www.drupal.org/project/gin) admin theme's look. It solves a specific,
annoying problem: Layout Builder's editing UI renders in your site's **front-end**
theme, so a site that uses Gin for admin but Olivero (or a custom theme) for the front
end ends up with an unstyled, hard-to-read Layout Builder. This module makes the
layout-editing experience look like Gin **without** switching your site's themes.

It works quietly and automatically. It detects when you're on a Layout Builder route,
checks that the active theme isn't already Gin, and then swaps in its own Gin-styled
templates and CSS/JS for the layout UI, the "Add block"/"Configure section" dialogs,
and the Media Library. All of its styles are namespaced (with a `glb-` prefix) so they
don't bleed into or fight with your front-end theme. If your site already uses Gin as
its front-end theme, the module sensibly does nothing.

A small settings form lets you tune a few behaviors: how the Toastify notification
library is loaded (useful under a strict Content Security Policy), whether the region
preview starts on, whether to hide Layout Builder's "Discard changes" and "Revert to
defaults" buttons, and whether saving keeps you on the edit page. For developers there
are two alter hooks to extend the route detection (for example to cover Layout Builder
embedded in Page Manager), and an optional **Gin LB Plus** submodule that adds a more
opinionated, tabbed block/section picker.

It requires core's **Layout Builder**, plus the **Gin** theme and the **Gin Toolbar**
module. Note it targets **Drupal 11.2+** and **conflicts with `lb_claro`** (don't use
both).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its dependencies, and (optionally) the Gin LB Plus submodule.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

The re-skin itself is automatic — there's nothing to place. Its settings form sits at
**Configuration → User interface → Gin Layout Builder settings**
(`/admin/config/gin_lb/settings`).

## How to use it

Once the module and its dependencies are enabled, open any entity that uses Layout
Builder and edit its layout — the editing UI, its dialogs, and the Media Library now
appear in Gin's style. If you want to change the defaults (hide certain buttons, alter
the Toastify loading, and so on), adjust the [Configuration](configuration/index.md).
