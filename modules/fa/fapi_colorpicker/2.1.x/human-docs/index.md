# Colorpicker form element — manual setup guide

**Colorpicker form element** (`fapi_colorpicker`) provides a reusable `colorpicker`
Form API element for custom Drupal forms. It is backed by the browser's native HTML5
colour input (`<input type="color">`) — the operating system's own colour picker —
paired with a companion hex text field so an editor can also type an exact value like
`#1a2b3c`.

It is a developer building block, not a point‑and‑click feature. There is no admin UI,
route, permission, or service: you place the element in a form array with
`'#type' => 'colorpicker'` and the module handles rendering, its JS/CSS library, and
validation. Submitted values are normalised to a seven‑character lowercase hex string
including the leading `#`, invalid input falls back safely to `#000000`, and the
rendered hex is HTML‑escaped, so it is safe to reuse across custom forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the element is used from code, not the admin UI.

## Where it lives in the admin menu

The module adds no admin page. It is a developer tool: you reference its element type
from PHP in your own forms.

## How to use it

In any custom form — a config form, block configuration, a Views or Layout Builder
settings form, or a custom entity form — add an element of type `colorpicker`:

- `#type => 'colorpicker'` renders the native swatch plus a hex text input.
- `#default_value` — prefill the picker with a hex string (for example a previously
  saved brand colour).
- `#required => TRUE` — make the colour field mandatory.

On submit, the value is validated against a six‑digit hex pattern, normalised to
lowercase `#rrggbb`, and (on malformed input) falls back to `#000000`. The element's
JavaScript and CSS library is attached automatically when it renders, and it works
inside multistep or AJAX forms. Use it to collect a theme accent colour, a per‑entity
colour, or to build a palette editor from several colorpicker elements.
