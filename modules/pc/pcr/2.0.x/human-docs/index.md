# Pretty Checkbox Radio — manual setup guide

**Pretty Checkbox Radio** (`pcr`) restyles Drupal's plain checkbox and radio inputs
into modern, button-friendly "pretty" elements. Instead of the default small square
or circle next to a label, each option becomes a tappable button — handy for
segmented toggles, "pick one" survey questions, and touch-friendly forms. It works
in two contexts: as a **field widget** on entity edit forms, and as a **Better
Exposed Filters (BEF)** widget on Views exposed filters.

Under the hood there is nothing to save globally and no admin page — the module
simply adds a rendering flag to the elements you opt in, hides the raw input, and
attaches a small CSS library that draws the button look. The input stays fully
accessible: the label wraps the visually hidden checkbox/radio, so the whole button
is clickable and works with keyboards and screen readers.

You turn it on per field (on *Manage form display*) or per exposed filter (in the
Views UI). It supports `boolean`, `list_string`, `list_integer`, `list_float`, and
`entity_reference` fields. Because it is purely presentational, it stores nothing
and gates nothing — there is no security surface to worry about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Better Exposed Filters.
2. [Configuration](configuration/index.md) — apply it as a field widget or as a
   Views exposed-filter widget, and how to customize the look.

## Where it lives in the admin menu

Nowhere as a settings page — Pretty Checkbox Radio has no global configuration.
You enable it exactly where you already configure the form element: on a bundle's
**Manage form display** for a field, or in the **Views UI** for an exposed filter.
See [Configuration](configuration/index.md) for the click-through.
