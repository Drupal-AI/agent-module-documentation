# Full Reset — manual setup guide

**Full Reset** (`full_reset`) adds options to **fully remove the theming (wrapper
markup) from fields and Layout Builder blocks**. This is a *markup* reset, not a
site reset — it strips the default wrapper elements and classes Drupal adds around a
field or a Layout Builder block, giving themers clean, un-wrapped output to style
from scratch.

It is especially useful in component-based theming, where you are using layout
definitions and Layout Builder and want the raw field/block output without Drupal's
default surrounding markup getting in the way of your components.

The module depends only on core's **System** module. One caveat to be aware of: to
work with Layout Builder blocks it currently relies on a core patch (issue
[#3015152]); the field-level reset does not need it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no central configuration page** — you apply the reset per field or
per Layout Builder block on their display settings, as described below.

## How to use it

Once enabled, Full Reset adds an option to remove the wrapper markup when you
configure a field's or a Layout Builder block's display. Turn it on where you want
clean, un-wrapped output — for example on fields whose markup your component styles
directly. Leave it off elsewhere and Drupal's normal theming applies. For Layout
Builder blocks specifically, remember the core patch noted above may be required.
