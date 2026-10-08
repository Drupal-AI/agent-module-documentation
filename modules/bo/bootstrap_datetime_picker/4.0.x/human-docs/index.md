# Bootstrap DateTime Picker — manual setup guide

**Bootstrap DateTime Picker** (`bootstrap_datetime_picker`) replaces the plain
HTML5 date input on your Date/time and Date-range fields with a polished
Bootstrap-styled calendar, powered by the **Tempus Dominus** JavaScript library.
Instead of the browser's built-in date box, editors get a proper pop-up calendar
and clock they can click through.

It works in three places: as a **field widget** for core Date/time (`datetime`)
and Date-range (`daterange`) fields, as a **Webform element** so you can add the
picker to a Webform, and as a **render element** you can drop into a custom form.
A global settings page controls the shared look and behaviour (icon set, whether
the library and icons load from a CDN or a local copy, side-by-side layout,
components, theme, language), and each field widget adds its own per-instance
options on Manage form display — display format, minimum/maximum date, disabled
weekdays, blackout dates, and time granularity.

The module depends on core's **Datetime** module and the third-party **Tempus
Dominus** library, which you either self-host under `/libraries/tempus-dominus`
or load from a CDN by ticking one setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the Tempus
   Dominus library (or switch to the CDN), and enable the module.
2. [Configuration](configuration/index.md) — the global settings form and the
   per-widget options, field by field.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Bootstrap
DateTime Picker** (`/admin/config/content/bootstrap_datetime_picker`), gated by
the core *Administer site configuration* permission.

## How to use it

**On a Date/time or Date-range field:**

1. Go to the field's **Manage form display** (for example on a content type).
2. Change the widget for your date field to **Bootstrap DateTime Picker** (for a
   Date-range field, its date-range variant appears).
3. Click the gear icon to set per-widget options — display format, minimum and
   maximum selectable date, disabled hours, disabled weekdays (for example
   weekends), specific blackout dates, and Bootstrap layout classes.

**On a Webform:** add the **Bootstrap DateTime** element from the Webform element
browser (this needs the Webform module).

**In a custom form:** use the render element type directly:

```php
$form['when'] = [
  '#type' => 'bootstrap_datetime_picker',
  '#title' => $this->t('When'),
];
```

All three render the same Tempus Dominus picker, combining the global defaults
with any per-instance options. Common things people do with it: constrain
selectable dates with a min/max, disable weekends or holidays on a booking-style
field, show the picker inline (always visible), switch between Font Awesome and
Bootstrap Icons, force a light/dark/auto theme, and localise the calendar to a
chosen language.
