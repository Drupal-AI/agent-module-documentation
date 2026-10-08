# Compact Date Range Formatter — manual setup guide

**Compact Date Range Formatter** (`daterange_compact`) displays date and
date-range fields in a shortened, human-friendly form that leaves out repeated
parts. Instead of `24 January 2017 – 25 January 2017`, it renders
`24–25 January 2017`; a same-year range becomes `29 January–3 February 2017`, and
a same-day time range shows as `9:00am–4:30pm, 1 April 2017`. When the start and
end are identical, it collapses to a single value.

It adds a **"Compact"** field formatter you can use on core `daterange`,
`datetime` and `timestamp` fields. The rules for how each case is shortened live
in reusable **format** definitions, which you manage as configuration — so you
can define, say, a short and a medium format once and pick which to use per field
display. Two formats ship ready to use: **Medium (date only)** and
**Medium (date & time)**.

The same logic is also available to developers through a service
(`daterange_compact.formatter`) for producing compact ranges in custom code,
Twig, or REST output. The module requires core's **Datetime Range** module and
adds no permissions beyond the standard "Administer site configuration".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Datetime Range dependency and
   installing with Composer.

## Where it lives in the admin menu

The compact **formats** are managed at **Configuration → Regional and language →
Compact date and time range formats**
(`/admin/config/regional/daterange-compact-format`). Applying the formatter to a
field happens on that entity's **Manage display** tab, not on a settings page.

## Applying the formatter to a field

1. Go to the entity's **Manage display** (for example **Structure → Content
   types → (type) → Manage display**).
2. For your date-range, date, or timestamp field, set the **Format** to
   **Compact**.
3. Click the settings cog and pick a **Format** from the list (for example
   *Medium (date only)*). Save.

## Managing compact formats

Each compact format is a small set of patterns and separators. Go to
**Configuration → Regional and language → Compact date and time range formats**
and **Add format** (or edit one). You set:

- **Default pattern** *(required)* — the fallback pattern, used when start and
  end are the same or no shorter case applies. It uses the same PHP date tokens
  as Drupal's core date formats (for example `j F Y`).
- **Default separator** — what goes between the two ends in the default case
  (for example ` – ` or ` to `).
- **Same-day**, **same-month** and **same-year** patterns and separators —
  optional. Each case is used only when you fill in at least one of its start/end
  patterns; otherwise the format falls back to the default. This is how you avoid
  repeating the month (`24–25 January 2017`) or the year
  (`29 January–3 February 2017`).
- **Omit duplicate am/pm** — drop a repeated am/pm marker within a same-day time
  range.
- **Omit zero minutes** — drop `:00` when the minutes are zero (with a
  configurable token to strip, `:i` by default).

Formats are stored as exportable configuration, so you can define them once and
deploy them across environments. The two preinstalled formats — *Medium (date
only)* and *Medium (date & time)* — are good starting points to copy.

## Using it in code

Developers can format compact ranges without a field, via the
`daterange_compact.formatter` service:

```php
$svc = \Drupal::service('daterange_compact.formatter');

(string) $svc->formatDateRange('2017-01-24', '2017-01-25', 'medium_date');
// => "24–25 January 2017"

(string) $svc->formatTimestampRange(1491036000, 1491057000, 'medium_datetime');
// => a same-day time range, e.g. "9:00am–4:30pm, 1 April 2017"
```

Both methods accept an optional timezone and langcode and return a
`FormattedDateTimeRange` value object (cast to string for the rendered text). See
the [`agent/`](../agent/start.md) docs for the full service reference.
