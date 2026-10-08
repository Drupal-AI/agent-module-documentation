# Select a11y — manual setup guide

**Select a11y** (`select_a11y`) provides an accessible multiple-select widget: a
searchable, keyboard- and screen-reader-friendly replacement for Drupal's long
multi-select lists. It wraps the Pidila `select-a11y` JavaScript library and makes
picking several options from a big list far more usable, without sacrificing
accessibility.

The native multi-select box is functional but painful once a list grows past a
handful of options — hard to scan, awkward to operate with a keyboard, and clumsy
for screen-reader users. Select a11y replaces that experience with a widget that
adds a search box and proper keyboard and assistive-technology support. It is a
purely presentational, accessibility-positive change: it alters how a select field
or filter looks and behaves, and has no role in content modelling or access
control. It ships one optional submodule, **Select a11y for Facets**
(`select_a11y_facets`), which brings the same accessible widget to Facets.

There is no global settings screen — you turn the widget on where you want it, by
choosing it as the widget for the relevant fields or exposed filters.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the Facets submodule.

## How to use it

Once enabled, select the Select a11y widget where you want the accessible
experience:

- **Entity fields** — on a content type's (or other entity's) **Manage form
  display** screen, choose the Select a11y widget for a multi-value list or
  reference field.
- **Facets** — enable the `select_a11y_facets` submodule and choose the accessible
  widget on the relevant facet.

The field or filter then renders as a searchable, keyboard-accessible multi-select.
