# Flatpickr datetime picker — manual setup guide

**Flatpickr datetime picker** (`datetime_flatpickr`) replaces Drupal's default
date inputs with the lightweight [flatpickr](https://flatpickr.js.org/)
JavaScript calendar and time picker. Instead of the plain browser date box, your
editors get a friendly pop‑up calendar with optional time selection, min/max
bounds, disabled dates, localization, and more — all configured per field, with
no jQuery UI involved.

It provides three field **widgets**: one for core **Date/time** fields
(`datetime_flatpickr`) and two for **Date‑range** fields
(`datetime_range_flatpickr`, a single‑input range picker, and
`datetime_range_separate_inputs_flatpickr`, with separate start/end inputs). You
choose the widget on an entity's *Manage form display* tab and then open the
widget's settings cog to tune it. There is no global settings page — each field
instance carries its own options.

Two optional submodules extend the same picker to other places:
**datetime_flatpickr_bef** turns Views exposed date filters (via Better Exposed
Filters) into flatpickr pickers, and **datetime_flatpickr_webform** adds a
flatpickr date element to Webform. There is also a reusable `datetime_flatpickr`
form element for developers building custom forms.

By default the flatpickr library loads from a CDN, but you can self‑host it by
dropping a copy into `libraries/flatpickr`. The calendar also localizes itself
automatically to the site's current interface language.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) self‑host the flatpickr library or add a submodule.
2. [Configuration](configuration/index.md) — choose a widget on Manage form
   display and set its options, field by field.

## Where it lives in the admin menu

There is no central settings page. You configure the picker per field at
**Structure → Content types → *(your type)* → Manage form display**
(`/admin/structure/types/manage/<type>/form-display`), by choosing a Flatpickr
widget for a Date/time or Date‑range field and opening its settings cog.

## How to use it

1. Make sure your content type has a **Date/time** or **Date‑range** field.
2. Go to that type's **Manage form display** tab.
3. In the **Widget** column for the field, choose one of the Flatpickr widgets:
   - **Flatpickr** for a Date/time field (single date, optionally with time).
   - **Flatpickr range** or **Flatpickr range (separate inputs)** for a Date‑range
     field.
4. Click the settings cog (⚙) to open the options, adjust them (see
   [Configuration](configuration/index.md)), click **Update**, then **Save**.

The next time someone edits that content, the field opens a flatpickr calendar.
