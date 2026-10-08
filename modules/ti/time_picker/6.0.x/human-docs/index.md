# Time and Time Range Picker Field — manual setup guide

**Time and Time Range Picker Field** (`time_picker`) provides two field types: one
for a single **time of day** and one for a **range of times** — each *without* a
date attached. It ships an attractive, responsive picker widget that supports both
12- and 24-hour formats and a choice of colour themes (Sky blue, Iris blue, Parrot
green, and others).

The problem it solves is a modelling one. Drupal core's datetime field always
carries a date along with the time, which is correct for an event but wrong for the
many things that are *times but not dates*. Opening hours are "09:00 to 17:00 on
Mondays generally", not on one particular Monday. A class runs at 14:30 every week;
a booking slot, a shift pattern, a broadcast schedule and a delivery window are all
recurring times. Forcing a date onto them means either an arbitrary date nobody
should see, or a value that has to be interpreted rather than simply read. A
dedicated time field stores what the data actually is.

A few things follow from those semantics and are worth keeping in mind as you model
your content. **A time without a date has no timezone** — 09:00 reads as 09:00
wherever the visitor is, which is exactly right for opening hours and exactly wrong
for anything a visitor in another country needs to convert. **A range can cross
midnight** — a shift from 22:00 to 06:00 is perfectly normal, so be deliberate about
how you sort or filter such values. And **a time is not a schedule**: this field
stores *when*, not *on which days*, so opening hours still need a day dimension
alongside it — that is a content-modelling decision, not something the field
supplies.

The module depends on core's **Datetime** module and works on Drupal 8 through 11.
Because these are field types, you set them up through the Field UI rather than a
central settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no central configuration page. Once the module is enabled, you add its
fields to a content type (or any fieldable entity):

1. Go to **Structure → Content types → *your type* → Manage fields**.
2. Click **Add field** and choose either the **Time** picker field or the
   **Time range** picker field.
3. Save, then on **Manage form display** confirm the picker widget is selected —
   this is where you pick the 12- or 24-hour format and the colour theme for the
   picker.
4. On **Manage display**, arrange how the stored time (or time range) is shown to
   visitors.

Editors then get the styled time picker when they create or edit content.
