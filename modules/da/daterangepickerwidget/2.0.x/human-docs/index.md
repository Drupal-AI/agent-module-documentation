# jQuery UI DateRangePicker Widget — manual setup guide

**jQuery UI DateRangePicker Widget** (`daterangepickerwidget`) brings the popular
[jQuery UI DateRangePicker](http://tamble.github.io/jquery-ui-daterangepicker/)
into Drupal — a calendar-style date-range picker that looks and behaves much like
the one in Google Analytics, with preset ranges ("Today", "1 week", "Last 3
months") alongside free custom selection.

It gives you three ways to use that picker. It registers a new **field type** so a
content type can store a date range picked from the widget; it exposes a reusable
**`daterangepicker` form element** you can drop into any custom form (with
options for preset ranges, min/max dates, number of months shown, month/year
dropdowns, and more); and through its submodules it integrates with **Views
exposed filters** and the **Better Exposed Filters** module so site visitors can
filter a listing by date range using the same friendly picker. The JavaScript API
options are customisable — including custom `presetRanges` — via form properties
or `hook_form_alter()`.

The one setup wrinkle is that the underlying picker is a JavaScript library, and
this module installs it through **Asset Packagist**. Your project's `composer.json`
must be set up to use Asset Packagist before the `composer require` will pull the
library in — see the Installation page for what that means.

Once installed and enabled, the widget appears as a choice on date-range fields
and exposed filters; there is no central settings page. The picker's behaviour is
configured per field, per filter, or per form element.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — set up Asset Packagist, install with
   Composer, enable the module, and pick the submodules you need.

There is **no configuration page** for this module. You select and configure the
picker on a field's *Manage form display*, on an exposed filter, or as a
`#type => 'daterangepicker'` form element in custom code.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types → *(your type)* → Manage form display** (choose the DateRangePicker widget
for a date-range field), and — with the `drpw_bef` submodule — from a View's
**exposed filter** settings, where the picker becomes an option for date filters.
