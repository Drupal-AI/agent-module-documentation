# Field Time — manual setup guide

**Field Time** (`field_time`) provides two clock-time field types — **Time** (a
single time of day like `14:30:00`) and **Time Range** (a start/end pair) — plus a
reusable `time` form element. It fills a gap in core: sometimes you want to store
just a *time*, not a full date-and-time. Opening hours, class or session times,
appointment slots, shift start/end — these are all times of day that shouldn't drag
a date along with them.

Each value is stored as a native database `TIME` column (`HH:MM:SS`), which means
it sorts and filters correctly as a real time rather than as text. The fields are
added through the normal **Field UI**, and each comes with a widget and a formatter.
The widgets render an HTML5 `<input type="time">` (the browser's native time
picker) and can optionally allow seconds with a configurable step. The formatters
render the stored value through a PHP `date()`-style format string, so you control
whether it shows as 12-hour with am/pm, 24-hour, with or without seconds; the range
formatter additionally takes a small template so you can present a range as
`start ~ end`, `start – end`, or whatever you like. Time Range enforces that the end
is later than the start.

There's no admin settings page, no permissions and no Drush — you just add the
fields and configure their widget and formatter per bundle. The module requires
core's **Datetime** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the `#type =>
'time'` render element — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Datetime.
2. [Configuration](configuration/index.md) — adding the fields, and the widget and
   formatter settings for both Time and Time Range.

## Where it lives in the admin menu

There is no settings page of its own. You add the fields through the standard
**Field UI**: on a bundle's *Manage fields*, click **Add field** and choose
**Time « human »** or **Time Range « Human »**, then set the widget on *Manage form
display* and the formatter on *Manage display*.
