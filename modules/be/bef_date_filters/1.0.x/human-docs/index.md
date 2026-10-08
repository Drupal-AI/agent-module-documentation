# BEF Date filters — manual setup guide

**BEF Date filters** (`bef_date_filters`) adds date-specific widgets to the
[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters)
module, so that an exposed date filter on a View can be a date picker or a
from/to range control instead of a plain text box.

Better Exposed Filters improves how Views exposed filters look — checkboxes
instead of a multi-select, links instead of a dropdown — but its built-in widgets
are aimed at lists and text. Exposed through plain Views, a date filter renders as
a text input into which the visitor is expected to type a value in exactly the
format the filter can parse, which is a reliable way to produce empty result
sets. This module adds the date-aware widgets — date pickers and range controls
appropriate to the filter's operator — that make an exposed date filter actually
usable.

There is no settings page for this module. You turn the widgets on per exposed
filter, right inside the Views UI, alongside Better Exposed Filters' own widget
settings.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the caching notes for date filters — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

BEF Date filters has no admin settings page of its own. Its widgets appear as
options when you configure an exposed **date** filter on a View under
**Structure → Views**, after you have set that filter's exposed widget to Better
Exposed Filters.

## How to use it

1. Enable the module (Better Exposed Filters must be enabled too — see
   [Installation](installation/index.md)).
2. Edit a View that has a **date** field or filter exposed to visitors.
3. In the exposed filter's settings, with Better Exposed Filters selected as the
   widget, choose the date picker or range widget this module adds.
4. Save the View. Visitors now get a proper date control instead of a
   free-text box.

**One thing to watch — caching.** Exposed input varies the result set, so a
display with date filters needs the right cache contexts. And a date range that
includes "today" is time-dependent: a listing cached for a day will show
yesterday's idea of "this week". Set the view's cache max-age accordingly.
