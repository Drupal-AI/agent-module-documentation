# Simple Open Hours — manual setup guide

**Simple Open Hours** (`simple_open_hours`) provides a Drupal **field type for
opening hours** — the "when is this place open?" information you attach to a
business, venue, office, or any content that has a weekly schedule. You add the
field to a content type (or any entity), and editors fill in the open and close
times for each day of the week.

Its defining trick is that all seven days' hours are stored in **one table row**,
which keeps the data tidy and makes it easier to build calendars and schedules on
top of it. On display, the field can also show whether the place is **currently
open**, and it offers a few presentation choices: whether to show closed days, the
separator between times, and the time format. The first day of the week follows
your global site configuration, so you don't set that per field.

You add and configure the field through Drupal's standard **Manage fields** and
**Manage display** screens — there is no separate settings page for the module
itself. It depends on core's **Datetime** module and the contributed **Time Field**
module (`time_field`), and it has no submodules. It is purely a content and display
feature with no access-control role — the hours are ordinary editorial content.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it,
   along with its dependencies.

## How to use it

1. Go to a content type's **Manage fields** screen (for example
   **Structure → Content types → Article → Manage fields**) and click **Add
   field**.
2. Choose the **Simple Open Hours** field type, give it a label, and save.
3. Configure the field as needed. On the entity's **Manage form display** you get
   a widget for entering each day's open and close times; on **Manage display**
   you can set the display options — whether closed days are shown, the separator,
   and the time format.
4. Edit a piece of content of that type, fill in the weekly hours, and save. On the
   rendered page the hours appear, and the field can indicate whether the place is
   open right now.
