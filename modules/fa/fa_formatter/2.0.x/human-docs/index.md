# Font Awesome Formatter for Int List — manual setup guide

**Font Awesome Formatter for Int List** (`fa_formatter`) is a field formatter that
turns a plain integer field into a row of repeated icons. If a node stores the
number `4`, the formatter renders four stars (or four of whatever Font Awesome
icon you choose). It is the standard, no-code way to show a stored rating,
difficulty level, priority, or capacity meter as a graphic instead of a bare
number.

The value stays a number in the database — editors still enter `1`, `2`, `3` in a
select or integer field — and only the *display* changes. You pick the formatter
on a field's **Manage display** tab and paste in the icon's HTML/CSS class. There
is no processing or interactivity: it simply outputs the integer as that many
icons. (For an interactive "click to rate" widget you would want the Rate or
Fivestar modules instead — this module is display-only.)

Two things are worth knowing up front. First, the module renders the icon markup
but **does not ship the Font Awesome library** — your theme or a Font Awesome
module must load it, otherwise you get blank space where the rating should be.
Second, because the icons are a decorative repetition of a number, make sure the
underlying value is available to assistive technology so a screen reader does not
meet a run of unlabelled glyphs. You can also point it at any icon set that uses
the same class-based markup (for example a smaller custom icon font), not only
Font Awesome.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
configure it per field on **Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

Font Awesome Formatter for Int List adds no admin page of its own. You use it
entirely from **Structure → Content types (or any fieldable entity) → *(bundle)* →
Manage display**, where it appears as a format option for integer / list (integer)
fields.

## How to use it

1. Create a **List (integer)** or integer field on your content type and give it
   the range of values you want to allow (for example `1 2 3 4 5`).
2. Make sure Font Awesome (or your chosen icon font) is loaded by your theme.
3. On the bundle's **Manage display**, set that field's format to the Font Awesome
   formatter and enter the icon markup/class for the icon you want repeated —
   pick any icon from <https://fontawesome.com/icons> (stars, circles, flags, and
   so on).
4. Save. The stored number now renders as that many icons, consistently across
   every view mode and in listing/Views output.
