# AP Style Date Formats — manual setup guide

**AP Style Date Formats** (`date_ap_style`) displays dates the way the Associated
Press stylebook says they should look — abbreviated months like "Sept." (but
"March" through "July" spelled out), no ordinal suffixes, "noon" and "midnight"
instead of "12 p.m."/"12 a.m.", lowercase "a.m."/"p.m.", and the year dropped for
the current year. If you run a news, editorial, or journalism site, it makes every
date on the site match your style guide without anyone hand-typing the format.

It gives you two field formatters — both labelled **"AP Style"** — that you assign
on a bundle's *Manage display* page: `timestamp_ap_style` for `datetime`,
`timestamp`, `created`, `changed`, and `published_at` fields, and
`daterange_ap_style` for `daterange` and (optionally) Smart Date `smartdate`
fields. Both share a long list of on/off options: always show the year, print
"today" for the current day, show the weekday, append the time, hide the date,
put the time before the date (AP "TDP" ordering, e.g. "3 p.m. Thursday"),
noon/midnight handling, an "All Day" label, month-only display, and a date-range
separator (the word "to", an en dash, or a hyphen).

You set the site-wide defaults once on a small settings form, and each formatter
instance can override those defaults on an individual view display. The same
formatting logic is also available to developers as a service
(`date_ap_style.formatter`) and as a Twig filter — `{{ my_timestamp|ap_style }}`
— so you can reuse AP formatting in templates or custom code. The module has no
required dependencies (Smart Date is only an optional integration).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Everything else — assigning the formatters, the global defaults form, and the Twig
filter — is covered in the *How to use it* section below.

## Where it lives in the admin menu

The global defaults form sits at **Configuration → Regional and language → AP
Style Date Formats** (`/admin/config/regional/date-ap-style`). You need the
**Administer AP style settings** permission to open it.

## How to use it

**1. Set the site-wide defaults (optional).** Visit
`/admin/config/regional/date-ap-style` and tick the options you want as your
baseline: always display year, use/capitalize "Today", display the weekday,
display the time, hide the date, time-before-date, noon/midnight (and whether to
capitalize them), "All Day", month-only, the range separator (`to`, en dash, or
hyphen), and an optional timezone override. Save. Every AP Style formatter you add
later starts from these values.

**2. Apply a formatter to a field.** Go to the content type's (or other bundle's)
**Manage display** page — for example *Structure → Content types → Article →
Manage display*. Find your date, timestamp, or date-range field and set its
**Format** to **AP Style**. Click the gear icon to override any of the global
options just for that display. A publish date then renders as "Sept. 4, 2025", and
an event date range as "Sept. 4 to 6".

**3. Use it in a Twig template (for themers/developers).** The `ap_style` filter
formats an integer timestamp:

```twig
{{ node.created.value|ap_style }}
{{ my_timestamp|ap_style({display_time: true, use_today: true}) }}
```

There is no range filter — use the `daterange_ap_style` formatter (or the
service's `formatRange()` method) for start/end pairs. See the
[`agent/`](../agent/start.md) docs for the full service API and every option key.
