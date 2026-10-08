# FlipDown — manual setup guide

**FlipDown** (`flipdown`) renders a Date or Datetime field as an animated,
flip-clock-style **countdown** to that date — perfect for event launches, sales,
or deadlines. It is lightweight (no jQuery, a small bundle), uses CSS transitions
for the flip animation, is responsive, and can be themed with built-in themes or
your own, including customisable headings for translation.

FlipDown works in two places: as a **field formatter** on any Date/Datetime field,
and as a **Views field plugin**, so you can add a countdown to a view of dated
content too. Either way, the setup lives on the display — you switch the field's
format to FlipDown — so there is no separate admin settings form and no admin menu
item.

The countdown simply reflects the value of the date field, which is content the
visitor can already see, so FlipDown has **no access-control role** of its own.

If instead of a field you want a countdown as a *paragraph* or a *block*, the
maintainers point to the **EPT Countdown** (Extra Paragraph Types) and **EBT
Countdown** (Extra Block Types) modules respectively.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — setup happens on your date
field's display (or in a view), described in "How to use it" below.

## Where it lives in the admin menu

FlipDown adds no admin page. You use it from **Structure → Content types → *(your
type)* → Manage display** for a Date/Datetime field, or from the **Views** UI as a
field plugin.

## How to use it

**As a field formatter**

1. Make sure your content type has a **Date** or **Datetime** field (for example an
   "Event date").
2. Go to that bundle's **Manage display** tab.
3. In the **Format** column for the date field, choose the **FlipDown** formatter.
4. Configure any available options (such as a built-in theme and headings/labels
   for your language), then save.

**In a View**

1. Add the Date/Datetime field to your view.
2. Choose the **FlipDown** formatter/plugin for that field and configure it.

Either way, the field now displays as a live flip-clock counting down to its date.
