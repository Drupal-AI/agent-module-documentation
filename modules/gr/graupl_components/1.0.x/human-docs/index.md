# Graupl Components — manual setup guide

**Graupl Components** (`graupl_components`) provides a library of reusable UI
components — notably accessible menus and navigation — built on the **Graupl**
accessible-menu libraries. The components are made available through **Layout
Builder** and **UI Patterns**, so site builders can drop them into layouts and
patterns rather than hand-coding markup.

Graupl is a front-end framework focused on keyboard- and ARIA-accessible menus.
This module packages components on top of it and wires them into Drupal's
site-building tools, which makes it a theming and site-building aid: the
components are theme/authoring constructs and the module has no content model or
access-control role of its own.

One thing to be aware of before you reach for it: both this module and the Graupl
framework it builds on are described by their maintainers as **very early
stages**. It is not recommended for production sites until a stable release is
made — treat it as something to evaluate and build with cautiously for now.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its Graupl, Layout Builder and UI Patterns dependencies.

There is **no dedicated configuration page** for this module — you use its
components inside Layout Builder and UI Patterns.

## How to use it

Once the module and its dependencies are enabled, the Graupl-based components
become available where Layout Builder and UI Patterns let you place components —
for example when configuring a layout for a content type or an individual page,
or when building with UI Patterns. Add a Graupl navigation/menu component to a
region or layout section and configure it there. There is no separate settings
form to visit first.
