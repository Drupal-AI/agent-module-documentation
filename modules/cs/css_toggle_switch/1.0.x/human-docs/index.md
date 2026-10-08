# CSS Toggle Switch — manual setup guide

**CSS Toggle Switch** (`css_toggle_switch`) provides an **accessible, CSS‑only
toggle‑switch form element** — a styled on/off switch that is really just a themed
checkbox. Because it is built from a standard form control with CSS, it works
**without JavaScript** and stays keyboard‑ and screen‑reader‑accessible. It's a way
to render boolean inputs as the familiar sliding toggle rather than a plain
checkbox.

The module integrates the CSS Toggle Switch library and can be used standalone or
alongside Bootstrap or Foundation (the library documents the classes available for
each). It provides a form element you can use programmatically in custom code, and
it also integrates with **Better Exposed Filters** and, via a submodule, with
**Webform**.

It is a form/UI feature that only affects how a checkbox renders — it has no
content or access‑control role. It requires no other modules and supports Drupal
9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the Webform submodule.

There is **no central settings page** — the toggle is applied where boolean form
controls are configured (for example a Better Exposed Filters checkbox, a Webform
element, or a form element in custom code).

## Where it lives in the admin menu

CSS Toggle Switch adds no admin settings page of its own. You reach for it in the
places that render boolean controls — **Better Exposed Filters** settings on a
View, **Webform** element settings (with the submodule enabled), or a render
element in custom code.

## How to use it

- **In a View (Better Exposed Filters):** on a boolean exposed filter, choose the
  toggle‑switch rendering that this module makes available in the Better Exposed
  Filters options.
- **In a Webform:** enable the `css_toggle_switch_webform` submodule (see
  [Installation](installation/index.md)), then select the toggle‑switch style on a
  checkbox/boolean element.
- **In custom code:** use the form element the module provides to render a boolean
  input as a toggle switch programmatically.
