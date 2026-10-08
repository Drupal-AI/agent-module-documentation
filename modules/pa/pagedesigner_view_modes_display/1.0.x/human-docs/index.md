# Pagedesigner View Modes Display — manual setup guide

**Pagedesigner View Modes Display** (`pagedesigner_view_modes_display`) is an add‑on for
the [Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) drag‑and‑drop page
builder. It gives content editors the ability to **hide individual Pagedesigner elements
in specific view modes** — so a page built once can render differently depending on the
view mode it's shown in (full page versus teaser, for example). An element that belongs
on the full view can be suppressed in a compact display, without maintaining two
separate versions of the content.

It is a site‑building / display feature: it affects *rendering* only, and has no content
or access role beyond the permission it provides. Set up the base
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) module first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Pagedesigner.

Because this is a Pagedesigner add‑on rather than a standalone module, its setup is
folded into this page rather than a separate Configuration section.

## How to use it

1. Install and enable Pagedesigner and this module (see
   [Installation](installation/index.md)).
2. Visit the module's settings at
   **`/admin/config/pagedesigner-view-modes-display/settings`** and review the options
   there.
3. Open a page in the Pagedesigner editor and, for each element, choose the view modes in
   which it should **not** be displayed.
4. Save. The element is then hidden in those view modes and shown in the rest.

> **Permission:** this module provides its own permission. Visit **People → Permissions**
> (`/admin/people/permissions`) to grant it to the roles that should be able to control
> per‑view‑mode display.
