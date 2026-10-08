# Formatted Number Input — manual setup guide

**Formatted Number Input** (`formatted_number_input`) makes entering numbers with
units — prices, measurements, scores — much friendlier. It enhances Drupal's core
**Number**, **Decimal**, and **Float** fields with a widget that formats the value
live as you type (adding currency symbols, thousand separators, and more) and a
matching display formatter that shows the value with the very same formatting. The
values are still stored as ordinary numbers; only the presentation changes.

The module has two halves that work as a pair. The **Formatted Number Input
widget** provides real‑time input masking (powered by the AutoNumeric.js library)
with a rich set of options — a custom placeholder, nine rounding methods, an
optional "formula mode" that lets users type `15*3` and get `45`, select‑on‑focus
behaviour, and value‑based CSS style presets. It is fully **language‑aware**: for
each language on the site you can define its own unit/currency symbol, symbol
placement (prefix or postfix), thousand and decimal separators, sign placement,
negative‑number brackets, and more. The **"Formatted as in input widget" display
formatter** simply reads back the settings you configured on the widget and
applies them on output, so data entry and display always stay perfectly in sync.

Because it's a field widget and formatter, there is **no central settings page**.
Everything is configured on the field's *Manage form display* (the widget) and
*Manage display* (the formatter), exactly where you set up any other field
presentation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no admin settings
form. You set it up on your number field's display, as described in "How to use
it" below.

## Where it lives in the admin menu

Formatted Number Input adds no admin page. You use it entirely from **Structure →
Content types → *(bundle)* → Manage form display** (to choose the widget) and
**Manage display** (to choose the formatter) for any Number, Decimal, or Float
field.

## How to use it

1. Add or reuse a core **Number**, **Decimal**, or **Float** field on your
   content type (or other fieldable entity).
2. On the bundle's **Manage form display**, set that field's widget to
   **Formatted Number Input**. Then open the widget's settings to configure the
   global behaviour (placeholder, rounding method, formula mode, select‑on‑focus,
   style presets) and the **per‑language** formatting rules (unit/currency symbol,
   prefix/postfix placement, thousand and decimal separators, sign and
   negative‑bracket options).
3. On the bundle's **Manage display**, set the same field's formatter to
   **Formatted as in input widget**. It automatically applies the language‑aware
   formatting you defined on the widget, so what visitors see matches how the
   value was entered.
4. Add content and confirm the number formats live as you type in the form and
   renders with the correct symbols and separators on the page.
