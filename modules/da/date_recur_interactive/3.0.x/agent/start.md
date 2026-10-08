<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Recur Interactive Widget (date_recur_interactive) — agent index

One **field widget** for `date_recur` fields that renders a visual, JavaScript RRULE editor
instead of the raw rule textarea. Package `Field types`. Depends on **`date_recur`** (Recurring
Dates Field 3.x). Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 3.0.0-beta1.

- **The widget, how to enable it, its JS/CSS libraries, and how the editor maps to RRULE** →
  [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `DateRecurInteractiveWidget` (id **`date_recur_interactive_widget`**, label
  *"Date recur interactive widget"*), in
  `src/Plugin/Field/FieldWidget/DateRecurInteractiveWidget.php`, extending date_recur's
  **`DateRecurBasicWidget`**. `field_types = { "date_recur" }`.
- **No** field type, formatter, routes, permissions, services, hooks, Drush commands, or config
  schema of its own. It only changes how a `date_recur` field is **edited**. Selected per
  view form-display on *Manage form display*.
- Storage, the start/end/timezone form structure, and server-side RRULE validation all come
  unchanged from the parent `DateRecurBasicWidget`; this module adds only a client-side editor.

## Mechanism (from source)

- `formElement()` calls `parent::formElement()`, then stamps a shared `Html::getUniqueId('date-recur')`
  id onto three inputs via data-attributes: `data-date-recur-start` (value), `data-date-recur-timezone`
  (timezone), `data-date-recur-rrule` (rrule). It attaches library
  `date_recur_interactive/widget` and re-weights `first_occurrence` to `-10`.
- JS `js/date_recur_rrule.js` (`Drupal.behaviors.dateRecurRruleWidget`, using `core/once`) finds
  the rrule textarea by that id, **hides it**, inserts a *"Repeat?"* checkbox and a
  `.date-recur-widget` container, and on toggle initialises the editor and mirrors its output back
  into the (hidden) rrule textarea. On form submit it strips `name` from the editor's own inputs so
  only the real rrule value is submitted.
- JS `js/date_recur_rrule.widget.js` defines a jQuery UI widget `rrule.recurringinput` (adapted
  from Josh Levinger's rrule editor) that builds the frequency/interval/by-*/end/include-exclude
  controls, computes the RRULE with **bundled rrule.js**, and renders a live human-readable summary
  (`.text-output`) and the raw RRULE (`.rrule-output`).

## Libraries (`date_recur_interactive.libraries.yml`)

- **`rrule`** — bundled `lib/rrule.js/rrule.js` + `nlp.js` (BSD-3-Clause).
- **`widget`** — the two `js/*.js` files + `css/widget.css`; depends on
  `date_recur_interactive/rrule`, `core/jquery.ui.datepicker`, `core/jquery.ui.widget`,
  `core/once`. No external CDN; nothing to install manually.

See [fields/widget.md](fields/widget.md) for enabling it and the full control-to-RRULE mapping.
