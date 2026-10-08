# Datetime Now — manual setup guide

**Datetime Now** (`datetime_now`) adds a small **"Now"** button next to Drupal's
core Date/time edit widgets. Clicking it fills the date and time inputs with the
current date and time, taken from the visitor's browser clock — so editors can
stamp "now" into a datetime field with one click instead of typing it out.

The module is genuinely zero-configuration. It has no settings form, no
permissions, no Drush commands and nothing to store. It works by enhancing the
core **`datetime`** form element itself, which means the Now button appears
automatically on **every** widget built from that element, across all entity types
and bundles, the moment you enable the module. There is no per-field opt-in.

Concretely, the button shows up on the **Date and time** widget
(`datetime_default`) and on the **Datetime Range** widget (`daterange_default`),
where it is added to both the start and end inputs. It does **not** appear on the
**Select list** widget (`datetime_datelist`), which is built from a different form
element. One nice detail: the Now value respects the widget's seconds setting — if
the time input is configured to step in whole minutes, the button fills `HH:MM`
and drops the seconds.

The only dependency is core's **Datetime** module, which supplies the widgets this
module enhances.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no configuration page. Once enabled, the **Now** button simply
appears on Date/time edit forms wherever the core Date and time (or Datetime
Range) widget is used.

## How to use it

There is nothing to set up. After enabling the module, open any content edit form
that has a Date/time field using the **Date and time** or **Datetime Range**
widget. You'll see a **Now** button beside the date and time inputs; clicking it
fills them with the current moment in your browser's timezone. To turn the button
off for a particular field, switch that field to a widget that isn't based on the
core datetime element (such as the **Select list** widget), or disable the module
site-wide.
