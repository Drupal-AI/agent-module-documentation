# FAPI Collapsible — manual setup guide

**FAPI Collapsible** (`fapi_collapsible`) provides a lightweight, themeable
collapsible container for Drupal's Form API — a fieldset‑like wrapper whose contents
can be expanded or collapsed. Unlike core's `details` element, it is driven by a
theme template you can fully override, so you get an independently toggleable section
*without* the semantics (and default markup) of `details`.

It is a small building block for developers, not a point‑and‑click feature. Once
enabled, it registers a `collapsible` render element that form and render‑array
authors use in their own code. The element maps a handful of properties — title,
description, expanded/collapsed state, a DOM id, and a name — into template variables,
and the accompanying template renders the header and the collapsible body.

There is no admin UI, no routes, permissions, services, or external calls, so it is
safe to enable anywhere. Its entire footprint is the theme hook and its preprocessing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the module is used from code, not the admin UI.

## Where it lives in the admin menu

FAPI Collapsible adds no admin page. It is a developer tool: you use its render
element from PHP in a form or render array.

## How to use it

In a form or render array, add a `collapsible` element and set its properties:

- `#title` — the header title for the section.
- `#expanded` — `TRUE` to start open, `FALSE` to start collapsed.
- `#description` and `#description_attributes` — an optional description under the
  header, with custom attributes if you need them.
- `#id_collapsible` — a DOM id for targeting the section from JS or CSS.
- `#name` — a name for the collapsible region.

Put your sub‑elements inside it to group unrelated form controls into toggleable
blocks. Combine several collapsible elements to build accordion‑like UIs, or use one
as a `details` alternative when you do not want that element's semantics. To customise
the markup, override the module's `collapsible` template in your theme.

> The module is also handy with **Entity List**, where you can render filters as
> collapsible sections.
