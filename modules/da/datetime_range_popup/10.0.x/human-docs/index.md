# Datetime Range Popup — manual setup guide

**Datetime Range Popup** (`datetime_range_popup`) adds a single field **widget** for core
**Date-range** (`daterange`) fields: instead of the default HTML5 inputs, editors get start and
end inputs backed by a Materialize-style popup date/time picker. It is a friendlier way to enter
a start–end range — a booking or reservation window, an event's start and end, a promotion's
active period — and it can be tuned per field with an hour format, minute granularity, disabled
weekdays, a week-start day, and a list of specific excluded (blackout) dates.

You use it by switching a Date-range field's widget to **DateTime Range Popup** on the entity's
*Manage form display* screen. It builds two custom form elements (start and end), enforces that
the end is not before the start, and converts the picked values back to the storage timezone and
format when the content is saved. All settings are per-widget-instance, so different bundles can
configure the picker differently.

The module depends on core's **Datetime** and **Datetime Range** modules and works across Drupal
8 through 11. It has **no settings page, no permissions, no routes, and no Drush** — everything is
configured on the widget itself.

> **Heads-up: this widget loads assets from external CDNs.** Its picker pulls Bootstrap,
> bootstrap-material-design, Moment.js, and Google Fonts / Material Icons from third-party hosts
> (maxcdn, cloudflare, momentjs.com, fonts.googleapis.com). That means the widget depends on
> outbound requests to those hosts and is subject to their availability — and it has privacy
> implications for your editors. Self-hosting these assets (or overriding the library) is
> advisable for privacy and reliability. See [Installation](installation/index.md) for the full
> list.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — the widget settings, the two form elements, and
the JS data attributes — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and note the
   external-asset caveat.

## How to use it

1. Make sure you have a **Date-range (`daterange`)** field on an entity bundle (add one under the
   bundle's *Manage fields* if needed).
2. Go to the bundle's **Manage form display** screen.
3. For that field, change the **Widget** to **DateTime Range Popup** and click the gear icon to
   configure it.
4. Save.

The per-widget settings are:

| Setting | Options / default | Effect |
|---|---|---|
| **Hour format** | `12h` or `24h` (default `24h`) | How the time is displayed in the picker. |
| **Allow times** | 5 / 10 / 15 / 30 / 60 minutes (default `15`) | The minute increment offered. |
| **Disable days** | Mon–Sun checkboxes (default none) | Weekdays that cannot be selected (e.g. weekends). |
| **Week start** | Mon–Sun (default Sun) | Which day the calendar week starts on. |
| **Exclude date** | `YYYY-MM-DD` list, one per line or comma-separated | Specific dates to block (holidays, blackout days). |

The widget works on both date-only and date+time `daterange` fields, and the *Manage form
display* row shows a summary of the current settings. The full technical detail — the two form
elements, the `data-*` attributes passed to the JavaScript, and the value handling — is in
[`agent/configure/widget.md`](../agent/configure/widget.md).

## Where it lives in the admin menu

There is no settings page. Everything is configured on a bundle's **Manage form display** screen
(under **Structure**, then the entity type and bundle) by choosing the **DateTime Range Popup**
widget for a Date-range field.
