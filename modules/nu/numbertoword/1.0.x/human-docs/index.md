# Number to Word — manual setup guide

**Number to Word** (`numbertoword`) provides a **field formatter** that renders a
numeric field's value as words on display — `12345` shows as "twelve thousand
three hundred forty‑five". It works with integer, decimal and float fields and is
built on the Composer library `kwn/number-to-words`, which brings support for 30+
languages and locales.

The problem it solves is presentational: showing amounts in words alongside or
instead of digits. That is common on invoices and checks ("USD one thousand five
hundred only"), helpful for accessibility, and useful in educational, legal or
formal documents. Because it is a *formatter*, the stored value stays numeric — the
words are produced only when the field is displayed.

The formatter is configurable per field, with options for a prefix and suffix, an
optional thousands separator (English), the word used between the integer and
decimal parts (for example "point" or "and"), the output language/locale, and
whether to capitalize the first letter. If a chosen language fails, it falls back
to English. Its only Drupal dependency is core's **Field** module; the
`kwn/number-to-words` library is pulled in through Composer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `kwn/number-to-words` library) and enable the module.

The formatter's settings are configured per field on **Manage display**, described
in "How to use it" below — there is no separate site‑wide settings page.

## Where it lives in the admin menu

Number to Word adds no admin settings page. You configure it per field at
**Structure → Content types → *(your type)* → Manage display**, using the
formatter's gear icon.

## How to use it

1. Go to the entity's **Manage display** and find a numeric field (integer,
   decimal, or float).
2. Set that field's format to **Number to Word** (labelled `numbertoWord`).
3. Click the **gear icon** to open the formatter settings and adjust:
   - **Prefix** — text shown before the words (e.g. "USD").
   - **Suffix** — text shown after the words (e.g. "only").
   - **Thousand separator** — a character inserted between word groups (English
     only), e.g. producing "one million, two hundred thirty‑four thousand…".
   - **Decimal separator word** — the word placed between the integer and decimal
     parts, e.g. "point" (so `12345.67` → "…forty‑five point six seven").
   - **Language** — the locale used for conversion (30+ supported).
   - **Capitalize first letter** — capitalizes the first character of the output.
4. Click **Update**, then **Save**. Numeric values in that display now render as
   words automatically.

> **Troubleshooting.** If the formatter does not appear, confirm the module is
> enabled and clear caches (`drush cr`). If you see a "NumberToWords library not
> found" error, the `kwn/number-to-words` library is missing — see
> [Installation](installation/index.md).
