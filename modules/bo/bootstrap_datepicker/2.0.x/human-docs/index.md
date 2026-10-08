# Bootstrap Datepicker — manual setup guide

**Bootstrap Datepicker** (`bootstrap_datepicker`) replaces the default input on a
Date/time field with a Bootstrap-styled calendar popup, powered by the jQuery
[uxsolutions/bootstrap-datepicker](https://github.com/uxsolutions/bootstrap-datepicker)
library. Instead of the browser's native HTML5 date box, editors get a proper
pop-up calendar you can localise, format, and constrain — pick the visible date
format, the first day of the week, which days or dates are disabled, a
start/end range, an auto-close behaviour, and around forty other options the
library supports.

It works by swapping only the **editing UI**: the module provides a field widget
(`bootstrap_date_widget`) for core `datetime` fields that extends Drupal's normal
date widget, so date storage, timezones and validation all behave exactly as core
does — only the calendar the editor sees changes. You choose and configure the
widget per field, on each content type's **Manage form display** page; there is no
global settings screen.

One important setup detail: the calendar popup depends on a **third-party
JavaScript/CSS library** that you must download and place in your site's
`libraries/` folder. Without it the field still saves fine, but the fancy calendar
won't appear — so don't skip that step in [Installation](installation/index.md).
This guide is written for a **human** clicking through the admin UI; if you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. The module depends on core's
**Datetime**, **Datetime Range** and **System** modules, has no submodules, and
has no admin page, permissions or Drush commands of its own.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download and place the bootstrap-datepicker library, and enable the module.

## Where it lives in the admin menu

It has no page of its own (`configure: null`). You use it on each bundle's
**Manage form display** page — for example **Structure → Content types → Article →
Manage form display** (`/admin/structure/types/manage/article/form-display`) — by
choosing the *Bootstrap Datepicker* widget on a Date/time field.

## How to use it

1. Make sure the field you want to enhance is a core **Date/time** (`datetime`)
   field, and that you've installed the JavaScript library (see
   [Installation](installation/index.md)).
2. Go to the bundle's **Manage form display** page.
3. On the date field's row, open the **Widget** select and choose **Bootstrap
   Datepicker**.
4. Click the **gear/cog icon** to open the widget's settings, then set the options
   you want. The most commonly used ones:

   - **Format** — the visible date format, e.g. `dd/mm/yyyy`.
   - **Language** — a language tag (like `en` or `fr`) to localise the calendar's
     month and day names.
   - **Week start** — the first day of the week (Sunday through Saturday).
   - **Autoclose** — close the calendar the moment a date is picked.
   - **Clear button** — add a button to empty the field.
   - **Start date / End date** — restrict which dates can be selected, either as
     fixed dates or as relative offsets (e.g. "today minus one day").
   - **Disabled / highlighted days**, **dates disabled** — grey out weekends or
     specific holiday dates, or highlight certain days.
   - **Start view / min & max view mode** — open the picker on days, months or
     years, and constrain it to month- or year-only selection.
   - **Today button**, **calendar weeks**, **orientation**, **RTL**, and more.

5. Click **Update**, then **Save**.

Only the settings you change from their defaults are actually sent to the browser,
so the widget stays lightweight. These settings are stored on the form display and
export with your configuration like any other field-widget setting. See the
[`agent/`](../agent/start.md) docs for the full list of option keys and a
scripting example.
