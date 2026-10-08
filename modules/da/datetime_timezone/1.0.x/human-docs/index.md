# Datetime Timezone — manual setup guide

**Datetime Timezone** (`datetime_timezone`) provides a date field type and widget
that let the person entering a date also **choose the timezone it is in**, and
store that timezone together with the value.

Core stores datetime values in UTC and displays them in the site's or the viewer's
timezone. That is exactly right for a *timestamp* — a moment that happened — but
wrong for some real cases. An event listing that says "7pm" means 7pm *where the
event is*; if a conference in Tokyo and one in Denver sit in the same view,
normalising both to the site timezone misrepresents both. The missing piece is
that here the timezone is part of the **data**, not a display preference. This
module makes it part of the data: the field type extends core's `datetime` to
carry a timezone the editor selects in the widget, so the stored value knows its
own zone. That is the right model for scheduled local events, travel itineraries,
and anything where "the timezone this was entered in" is information worth keeping.

Because it is a **distinct field type** built on core `datetime`, one planning
point matters: as with any new field type, an existing core date field cannot be
converted to it in place. Adopting it for content that already exists is an
add-a-new-field-and-migrate exercise, so decide where you need it before the
content exists if you can.

The module works as soon as it is enabled — it adds the new field type and its
widget, which you attach and configure per field. As its own documentation states,
it has **three classes, no routes, no permissions, and no configuration page**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You add a field of the new
type to an entity and configure its widget and display on the field's *Manage form
display* / *Manage display* tabs.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage fields → Add field**, where you choose the timezone-aware
date field type, then set its widget on **Manage form display** so editors get the
timezone selector.
