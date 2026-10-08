# Configuration

Calendar Systems has **no central settings page**. Most of what it does happens
automatically when the module is enabled; the only thing you configure by hand is
the optional block (and, if you use them, the submodules). This page explains what
is automatic and where the few knobs are.

## What happens automatically

Once the module is enabled and caches are cleared:

- **All formatted dates localize.** The module replaces core's date formatter, so
  node created/changed dates, most themed dates, and the core `[date:*]` /
  `[node:created:*]` tokens render in the active calendar. You don't opt in per
  display.
- **Date input fields become calendar-aware.** Core's date, datelist, and datetime
  form elements and the standard Date/time field widgets (default, drop-down list,
  timestamp) are swapped for calendar-aware versions, and a bundled Persian
  date-picker popup is attached to date inputs — with no field-config change.
- **Views date filters and arguments localize**, so you can filter or provide a
  contextual filter using Jalali date input.
- **Persian input is normalized.** Persian digits (۰–۹) are converted to ASCII, and
  in Views date arguments Farsi relative-date words (امروز = today, دیروز = −1 day,
  فردا = +1 day, and so on) are interpreted correctly.

## How the calendar is chosen

The active calendar follows the **interface language**: Farsi (`fa`) → Persian,
English (`en`) → Gregorian. A single-language site defaults to Persian. This is why
Calendar Systems shines on multilingual sites — different languages can see
different calendars automatically.

## The Calendar Systems block

The one thing you place manually is the **Calendar Systems** block, which shows the
current (or relative) date. Add it through **Structure → Block layout** like any
block (you need the *Administer blocks* permission). Each block instance has its
own settings:

- **Calendar** *(default: global)* — **Persian**, **Gregorian**, or **global**
  (pick automatically by the site language).
- **Format** *(default: `Y/m/d H:i:s`)* — a standard PHP `date()` format pattern.
- **Timezone** *(default: user)* — use the **site** default timezone, the current
  **user's** timezone, or a specific one you choose.
- **Wrapper text** *(default: `{}`)* — surrounding text where the literal `{}` is
  replaced by the formatted date. It must contain `{}`, or it resets to `{}`.
- **Cache max-age** *(default: 3600 seconds)* — how long the block output is cached.

## Keeping some output Gregorian (escape tokens)

Because the formatter localizes everything, the module provides token variants that
force plain **Gregorian** output — perfect for machine-readable or SEO contexts
where a localized date would be wrong:

- `[date:gregorian]` — the medium date format, Gregorian.
- `[date:gregorian:<format_name>]` — a named date format (e.g. `html_datetime`),
  Gregorian.
- `[date:gregorian:custom:<PHP pattern>]` — a custom pattern, e.g.
  `[node:created:gregorian:custom:Y-m-d]`.

Use these in meta tags, structured data, or anywhere a crawler reads the date, so
your users still see Jalali while machines get Gregorian.

## Advanced note

The module ships with two Jalali/Gregorian implementations: a dependency-free
"poor man's" one (the shipped default) and a PHP-intl (`IntlCalendar`) based one.
The choice is a hard-wired constant in the module and switching it, or adding a
brand-new calendar, requires a code change — there is no plugin manager or UI for
it. For the everyday Persian/Jalali use case, the defaults are all you need.
