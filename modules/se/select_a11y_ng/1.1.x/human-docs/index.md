# Select A11y NG — manual setup guide

**Select A11y NG** (`select_a11y_ng`) turns Drupal `<select>` elements into an
accessible, searchable single- or multiple-select widget by wrapping the Pidila
`select-a11y` JavaScript library. It is a friendly, modernized fork of the original
Select A11y module, aiming for full WCAG / RGAA compliance with search, single and
multiple selection, custom placeholder text, and right-to-left support.

The module ships a render element and a field widget that work with list fields
(`list_string`, `list_integer`, `list_float`) and entity-reference fields. Behind
the scenes it builds a small JSON configuration (multiple-select on or off,
placeholder text, text direction, current language) and hands it to the JavaScript,
which instantiates the accessible select. Because it is a pure form-element and
widget — output only, with escaped rendering — it has no settings page, no
permissions, and no controllers; there is nothing to lock down. You configure it
per field, right where you choose form widgets.

Three optional submodules extend the same widget to other subsystems: **Select
A11y NG for Better Exposed Filters** (`select_a11y_ng_bef`) for Views exposed
filters and sort criteria, **Select A11y NG for Facets** (`select_a11y_ng_facets`)
to render facets as accessible dropdowns, and **Select A11y NG for Webform**
(`select_a11y_ng_webform`) to swap standard Webform select elements to the
accessible widget (turning off select2/chosen/choices in the process). Using one
component across fields, filters, facets, and webforms is the point — it keeps the
select experience consistent everywhere.

One installation nuance: this module expects the JavaScript library to be present
at `/libraries/select-a11y` (the `bordeaux-metropole/select-a11y` fork). See the
installation guide for how to get it there.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its JavaScript
   library, and enable any submodules you need.

## How to use it

There is no global configuration screen — everything is set per field on **Manage
form display**:

- Choose the **Select A11y NG** widget for a list or entity-reference field.
- Set its **placeholder** text (for example "Search in list") and toggle the
  in-widget **search** box on or off.

For the other surfaces, enable the matching submodule and choose the accessible
widget there: on a Better Exposed Filters exposed filter or sort, on a facet, or on
a Webform select element.
