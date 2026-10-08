# Time Range — manual setup guide

**Time Range** (`time_range`) provides a single field widget that shows only a
*start time* and an *end time* on core's **Date range** field — the date part is
hidden. It is the tidy way to capture a time window without exposing a date picker:
daily opening hours (09:00–17:00), event or session start/end times, shift times,
appointment windows, or "available from / to" slots.

The module adds no field type or storage of its own. You use a normal core **Date
range** field (of the *Date and time* type), and Time Range simply changes how that
field is edited: on the bundle's *Manage form display* you switch the field's widget
to **Time range**, and editors then see two native HTML5 time inputs instead of the
full date-and-time controls. The value stored is still an ordinary Date range value,
so all of core's behavior — including the validation that the end must not be before
the start — continues to apply.

The widget has just two settings, **Start time label** and **End time label**
(defaulting to "Start time" / "End time"), so you can rename the inputs to domain
terms like "Opens" / "Closes" or "Shift start" / "Shift end". Everything is stored
as form-display configuration, so it exports and deploys with the rest of your site
config. There is no admin settings page. The module requires core's Datetime and
Datetime Range modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page — you switch the widget on where you want time-only entry:

1. Add a **Date range** field to a bundle (content type, media type, taxonomy term,
   user, etc.), and choose **Date type: Date and time**.
2. Go to the bundle's **Manage form display**.
3. Find that field's row and set its widget to **Time range**.
4. Open the widget's **cog** to set the **Start time label** and **End time label**
   (for example "Opens" / "Closes"); click **Update**.
5. Click **Save**.

Editors now see two time inputs for that field — a start and an end — with no date
picker. The field still stores a full Date range value and still enforces that the
end is not before the start.

Because Time Range only changes the *editing* form, the date portion is still part of
the stored value. If you also want to hide the date on the rendered output, adjust
the field's **display format** separately on *Manage display* (for example choose a
formatter or format that shows only the time). You can also use the *Time range*
widget on one form mode and a different widget on another, mixing entry styles per
context.
