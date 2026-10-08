# JapaneseEraFormatter — manual setup guide

**JapaneseEraFormatter** (`japanese_era_formatter`) is a field formatter that
displays datetime field values using the Japanese imperial era (*wareki*)
calendar — Reiwa, Heisei, Showa, Taisho, and Meiji year notation — instead of the
Gregorian calendar. Your dates stay stored as normal Gregorian values; only the
way they are *displayed* changes.

It's built for sites that serve Japanese audiences or deal with Japanese culture,
history, or business, where events, archives, and publications are expected to
read in the traditional calendar. The module adds a single formatter plugin,
**Japanese Era Date Format** (`datetime_japanese_era`), for core **Datetime**
fields, and includes a built‑in table of era start dates so it can convert any
Gregorian date to the correct era and year automatically.

There is **no central settings page** for this module — it has no admin form of
its own. You turn it on per field, from the field's *Manage display* settings,
which is described in "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

JapaneseEraFormatter adds no admin page. You use it entirely from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage display**, where you
choose the formatter for a datetime field.

## How to use it

1. Make sure the entity you're working with has a **Datetime** field (core's
   `datetime` field type).
2. Go to that entity's **Manage display** tab — for example **Structure →
   Content types → Article → Manage display**.
3. Find your datetime field in the list and, in the **Format** column, choose
   **Japanese Era Date Format**.
4. Click the gear/settings icon beside the field to open the formatter options.
   Here you can set the storage date format and adjust the **output format
   string** that controls exactly how the era and year are rendered.
5. Click **Update**, then **Save**.

From then on, any place that renders that field through this display mode shows the
date in Japanese era notation. Because it only changes display, you can safely
apply it to some display modes and not others, and combine it with other
formatters elsewhere.
