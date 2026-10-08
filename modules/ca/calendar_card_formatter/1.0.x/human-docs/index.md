# Calendar Card Formatter — manual setup guide

**Calendar Card Formatter** (`calendar_card_formatter`) is a display formatter
for Date fields. Instead of rendering a date as plain text, it shows it as a
visual "calendar page" card — the month above the day, like a torn-off desk
calendar. It is a common design touch for event listings, news dates, and any
place a date deserves to stand out.

It is purely a field formatter: it changes how an existing Date field is
displayed and adds no content, permissions, or access role of its own. You pick
it on the field's display settings, the same way you choose any other formatter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. You choose the formatter per field under **Structure
→ Content types → [your type] → Manage display** (`/admin/structure/types`), or
on any other entity's Manage display screen.

## How to use it

1. Enable the module.
2. Go to the **Manage display** tab of the content type (or other entity) that
   has your Date field.
3. In the **Format** column for that field, choose the **Calendar Card**
   formatter.
4. Save. The date now renders as a calendar-page card wherever that field is
   shown.
