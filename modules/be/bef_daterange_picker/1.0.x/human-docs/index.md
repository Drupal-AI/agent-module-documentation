# BEF Date Range Picker — manual setup guide

**BEF Date Range Picker** (`bef_daterange_picker`) adds an enhanced date-range
picker widget to
[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters).
It gives a Views exposed date filter a friendlier calendar/range control, so
visitors can pick a date range from a nicer widget instead of typing dates into a
plain text box.

This is purely a presentation improvement for the exposed filter — it changes how
the date range is entered, not which results come back. The View's own access
rules still decide what a visitor may see; the picker has no access role of its
own.

There is no settings page for this module. You choose the picker per exposed
filter, in the Views UI, alongside Better Exposed Filters' other widget settings.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

BEF Date Range Picker has no admin settings page. The picker appears as a widget
option when you configure an exposed **date** filter on a View under **Structure →
Views**, once Better Exposed Filters is selected as that filter's widget.

## How to use it

1. Enable the module (core Views and Better Exposed Filters must be enabled too —
   see [Installation](installation/index.md)).
2. Edit a View with a **date** filter exposed to visitors.
3. In the exposed filter's Better Exposed Filters settings, choose this
   date-range picker as the widget.
4. Save the View. Visitors now get the enhanced range picker for that filter.
