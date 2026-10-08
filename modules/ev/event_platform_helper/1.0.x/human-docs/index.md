# Event Platform Helper — manual setup guide

**Event Platform Helper** (`event_platform_helper`) provides the functional tools for
building Drupal-powered event sites — particularly community conferences and
DrupalCamps. This code originally lived inside the Event Platform project and was
split out into its own module so it could support the Event Platform Starter site
template. If you are assembling an event site by hand rather than installing the full
bundle, this is the helper that supplies the moving parts.

Its main pieces are:

- **Session Scheduler** — an administrative drag-and-drop grid for assigning accepted
  sessions to rooms and time slots, with AJAX assignment/unassignment. It is
  configurable per content type, workflow state, and filter field.
- **Dynamic access control** — a custom access policy that automatically grants the
  "create session" permission while the event is in the `sessions_open` moderation
  state, with a matching cache context so cached pages reflect the current submission
  window. No manual role juggling as the window opens and closes.
- **Thematic blocks** — four ready-to-place blocks: **Home Hero** (event name, dates,
  location, description, CTA), **Header CTA**, **Copyright** (footer with event name and
  current year), and **Session Submission Confirmation** (a post-submission message
  with workflow links).
- **Time-slot generation** — a form that auto-generates time slots from your event's
  date fields, saving manual configuration.
- **Installation helpers** — on install it grants schedule-flagging permissions to
  authenticated users and, if both are present, extends the "My Schedule" flag to BOF
  sessions.

Everything it wires up follows normal Drupal access; it has no access-control role of
its own beyond the dynamic session-creation policy described above.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it alongside its Content Moderation and Smart Date dependencies.

This module has **no single settings page**. Its scheduler is configured on its own
admin screen and its blocks are placed through Block layout — see "How to use it"
below.

## Where it lives in the admin menu

Event Platform Helper does not add one central settings page. You work with its parts
in a few places: the **Session Scheduler** administrative interface (used to assign
sessions to rooms and time slots), the **time-slot generation** form, and **Structure
→ Block layout** (`/admin/structure/block`) where you place its Home Hero, Header CTA,
Copyright, and Session Submission Confirmation blocks.

## How to use it

1. Enable the module as part of your event-platform build (it is designed to work with
   the wider Event Platform stack, and pairs naturally with the Event Platform Starter
   template).
2. Use the **time-slot generation** form to create your event's time slots from its
   date fields.
3. Open the **Session Scheduler** to drag accepted sessions onto rooms and time slots;
   point it at the correct content type, workflow state, and filter field for how your
   site models sessions.
4. Place the **Home Hero**, **Header CTA**, **Copyright**, and **Session Submission
   Confirmation** blocks in the regions you want from **Structure → Block layout**.
5. Rely on the dynamic access policy to open and close session submissions
   automatically as the event moves in and out of the `sessions_open` moderation
   state — no manual permission changes needed.
