# Add to Calendar Date Augmenter — manual setup guide

**Add to Calendar Date Augmenter** (`addtocal_augment`) adds "Add to calendar"
links — Google Calendar, Apple/iCal, and Outlook — to the way a date field is
displayed, so visitors can save an event's start and end time straight into their
own calendar with one click. It needs no third‑party JavaScript library and doesn't
touch your stored data; it only augments the rendered output of a date field.

The clever part is *how* it attaches. Rather than being a standalone field
formatter you'd have to switch to, it's a **Date Augmenter** plugin: it layers on
top of any date formatter that supports the
[Date Augmenter](https://www.drupal.org/project/date_augmenter) API — most notably
[Smart Date](https://www.drupal.org/project/smart_date). That means you keep the
rich, feature‑full date display you already use and simply *add* calendar links to
its output, rather than choosing between them.

You configure it per field, right on the field's display settings. You can set the
calendar event's title, location, and description (all token‑aware, so they can pull
from the node title, a venue field, the body, and so on), trim long descriptions,
show icons instead of text, choose an inline list of links or a compact modal
"Add to calendar" button, decide whether links appear for past events, and control
timezone handling. Behind the scenes it generates a valid calendar event (a VEVENT
with summary, start/end, description, location, and a unique ID) plus a Google
Calendar link.

The module requires the **Date Augmenter** module and defines no admin page,
permissions, or Drush commands — all its settings live with the field formatter and
export with your display configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There's no settings page of its own. You enable and configure it inside **Manage
display** for the entity type and bundle whose date field you want to augment — for
a content type, that's **Structure → Content types → [type] → Manage display**
(`/admin/structure/types/manage/[type]/display`).

## How to use it

> **Prerequisite:** the date field must use a formatter that supports the Date
> Augmenter API, such as **Smart Date**. Core's default date formatter does not
> invoke augmenters, so the links won't appear with it.

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** page for the bundle with your event date field.
3. Open that date field's **formatter settings** (the gear icon). You'll see a
   **Date Augmenter** section listing available augmenters.
4. Enable **Add to Calendar Links** and set its options:
   - **Label** — text shown before the links (default *Add to calendar*); try
     something like "Save the date".
   - **Event title** — the calendar entry's title; supports tokens. Leave it empty
     to use the entity's own label (title).
   - **Location** and **Description** — both token‑aware, so you can point them at a
     venue field or the body. You can trim the description to a maximum length and
     append an ellipsis.
   - **Icons** — show calendar icons instead of text labels.
   - **Display as modal** — swap the inline list of links for a single button that
     opens a dialog.
   - **Show for past events** — off by default, so links disappear once an event is
     over; turn it on for an archive of recordings.
   - **Timezone handling** — the event's timezone comes from the date itself
     (falling back to the site default); you can have it ignore the timezone when
     it's UTC to avoid double‑conversion.
5. Save the display. Calendar links now render alongside the date wherever that
   view mode is shown.
