# Number Range Slider — manual setup guide

**Number Range Slider** (`number_range_slider`) provides an HTML‑native **range
slider** field widget for number fields. Instead of typing a value into a text
box, an editor drags a slider to pick a number within the field's allowed range.

The problem it solves is entry comfort: for bounded numeric values — a rating, a
percentage, a quantity with a clear minimum and maximum — a slider is often nicer
and less error‑prone than a free‑text field. The widget uses the browser's native
`range` input, so it needs **no JavaScript libraries**. There is one optional
extra: a small JavaScript snippet you can add if you want the current slider value
displayed as you drag, since the native input does not show that on its own.

Two things worth knowing. First, the slider only affects *input* — the field's own
validation (its minimum and maximum) still applies regardless of the widget, so
set those range constraints on the number field. Second, there is nothing to
configure globally; you switch a field to this widget on its form display. It works
on Drupal 10 and 11 with no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the widget is selected per field on **Manage
form display**, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You enable the widget on a field at
**Structure → Content types → *(your type)* → Manage form display**.

## How to use it

1. Make sure you have a **Number** field (integer, decimal, or float) on your
   entity, and that its **minimum** and **maximum** values are set in the field
   settings — the slider's range comes from those constraints, and they are what
   actually validate the value.
2. Go to the entity's **Manage form display** and, for that number field, choose
   the **Number Range Slider** widget from the widget dropdown.
3. Save the form display. The field now renders as a draggable slider on the
   entity's edit form.
4. *(Optional)* If you want the chosen value shown next to the slider as it moves,
   add the small JavaScript snippet the module documents — the native range input
   does not display its value on its own.
