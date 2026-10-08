# Time Zone (tzfield) — manual setup guide

**Time Zone** (`tzfield`) adds a **time-zone field type** to Drupal, so you can
store a tz-database identifier such as `Europe/London` or `America/New_York` on
any content type, user, taxonomy term, media item, or other fieldable entity.
It is the clean way to record "which time zone this thing is in" — an office, a
venue, an event, or a customer's profile.

Editors pick a zone from a select list. Two widgets ship: a **region-grouped**
select (the default), and a select **sorted by current UTC offset** that labels
each zone with its offset, for example `(UTC+01:00) Europe/London`. Per-field
settings let you exclude zones you never use, and default a new value to the
site's own time zone and/or the current user's configured time zone.

For display you get two formatters: the standard one prints the stored
identifier as-is, and **"Formatted current date"** shows the *current* local time
in the stored zone using a PHP date-format string you choose (for example just
the abbreviation like `GMT`, or a full `g:i a T`). That makes a simple
world-clock-style listing easy. The module needs no other modules, has no admin
settings page, and also ships a migrate plugin for importing legacy time-zone
data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

`tzfield` is a normal field type — you add and configure it through the Field UI,
so there is **no module settings page**.

1. **Add the field.** Go to **Structure → Content types → (type) → Manage
   fields → Add field**, and choose **Time zone**.
2. **Field settings.** On the field's settings you can:
   - Under **Time zones to be excluded**, remove zones you never want offered.
   - Tick **Use site's default time zone** to default a new value to the site
     time zone.
   - Tick **Use current user's time zone** to default it to the editing user's
     own time zone (only offered when Drupal is configured to let users set
     their own time zone; the site default is the fallback).
3. **Choose the input widget.** On **Manage form display**, set the field's
   widget to either **Time zone** (region-grouped select) or **Time zone with
   current offset** (sorted by, and labelled with, each zone's current UTC
   offset).
4. **Choose the display formatter.** On **Manage display**, pick either:
   - the default string formatter, which prints the raw identifier (e.g.
     `America/New_York`), or
   - **Formatted current date**, which renders the current time in the stored
     zone. Set its **Date format string** using PHP date tokens — `T` gives the
     abbreviation (e.g. `EST`), `g:i a T` gives a clock time with it.

The stored value is always a canonical tz identifier, so it feeds cleanly into
custom code (for example `DrupalDateTime::setTimezone()`) and interoperates with
other systems.
