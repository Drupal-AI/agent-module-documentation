# SD Breadcrumb — manual setup guide

**SD Breadcrumb** (`sd_breadcrumb`), also known as SmartDuo Breadcrumb, is an
advanced breadcrumb management module that gives site builders full control over
breadcrumb trails without writing any code. It replaces Drupal's basic, path-based
breadcrumbs with a flexible, two-tier system.

The heart of the module is a **two-mode, two-tier** approach. First, you set a
**default breadcrumb pattern per content type** for site-wide consistency; then you
can **override the breadcrumb on an individual node** whenever a page needs
something specific. At each level you choose between *System Default* (Drupal's
path-based trail) and a *Custom Pattern* that you compose yourself. Custom patterns
are built in a visual drag-and-drop builder where each segment has a label, a link
destination, an optional icon, and a display mode (text only, icon only, or both).
Labels can be static text or Drupal **tokens** like `[node:title]`, so breadcrumbs
can be dynamic and content-aware. Link destinations can be internal paths, external
URLs, anchored links, the front page, or no link at all. Icons are chosen through
the standard **Media Library** widget.

Global settings let you include or exclude the front-page and current-page
segments, replace the "Home" label with a custom icon, capitalise segment labels
(with a configurable ignore list), automatically remove duplicate segments, and set
a cache max-age. The module is security-conscious: all labels are stripped of HTML
tags to prevent XSS, and user-supplied input is validated (length limits, type
checks, path validation). It depends on core **Node** and **Media**, provides its
own permission, and needs configuration before it changes anything — it does not
alter breadcrumbs on enable until you set up patterns.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — global settings, content-type
   patterns, the visual builder, and per-node overrides.

## Where it lives in the admin menu

The settings page sits at **Configuration → User interface → SD Breadcrumb**
(`/admin/config/user-interface/sd-breadcrumb`). Per-node overrides appear in a
**Breadcrumb Settings** section on the node edit form.
