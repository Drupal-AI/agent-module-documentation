# Time Formatter — manual setup guide

**Time Formatter** (`time_formatter`) is a field display formatter that turns a
plain number into a readable duration. If you store a length of time as a number
of seconds or milliseconds in an integer, decimal, or float field — a lap time, a
video length, a "time spent" metric — this module displays it as something like
`1:23:45.678` or `2h 5m 9s` instead of a bare number, without changing how the
value is stored.

The module adds one formatter, called **"Time"**, that you pick on a field's
*Manage display* page. Three options control the output: whether the stored number
means **seconds or milliseconds**, which **display format** to use (four styles,
from the verbose `123h 59m 59s 999ms` to the compact `123:59:59`), and whether to
**always, optionally, or never** show an hours component. It has no dependencies,
no settings page, no permission and no submodules — it is purely a display
formatter you configure per field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You use it on any content type's (or other
entity's) **Manage display** page — for example **Structure → Content types →**
*your type* **→ Manage display**
(`/admin/structure/types/manage/<bundle>/display`).

## How to use it

1. Make sure the value you want to format lives in an **integer**, **decimal**, or
   **float** field and is stored as a number of seconds or milliseconds.
2. Go to that field's bundle **Manage display** page.
3. In the **Format** column for the field, choose **"Time"**.
4. Click the gear/settings icon to open the formatter options, then set:
   - **Storage** — how to read the stored number: **Seconds** or **Milliseconds**
     (the default is Milliseconds).
   - **Display** — the output style. The four choices are
     `123h 59m 59s 999ms`, `123h 59m 59s`, `123:59:59.999`, and `123:59:59`
     (the default is `123:59:59.999`). The first and third include milliseconds;
     the other two drop them.
   - **Hours** — whether to show the hours part: **Always** (the default),
     **Optional** (only when hours is greater than zero), or **Never** (roll all
     hours into the minutes).
5. Click **Update**, then **Save** the display.

A few worked examples:

- Milliseconds, format `123:59:59.999`, value `3661999` → `1:01:01.999`
- Seconds, format `123h 59m 59s`, value `3661` → `1h 1m 1s`
- Hours *Never*, format `123:59:59`, value `65000` ms → `1:05`

Because the setting lives on the display, you can reuse the same underlying field
across different view modes with a different time format in each.
