# DateTime Reset — manual setup guide

**DateTime Reset** (`datetime_reset`) adds an optional **"Reset" button** to
datetime field widgets, letting a content editor clear a date field's value in one
click.

It is a small content-editing convenience for optional date fields where clearing
the value is a common action. Rather than manually deleting what is already in the
date and time inputs, the editor clicks Reset and the field empties. The behaviour
is opt-in per field: you switch it on with a toggle in the field's widget
settings, so the button only appears where you want it. It works with core's
**Date**, **Date/Time**, and **Date range** fields.

It is purely a form-widget feature — it changes how the field is entered, not how
the value is stored and not who can access it. It depends only on core's
**Datetime** module.

The module works as soon as it is enabled and you turn the toggle on for a field;
there is no central settings page.

> **Note for SmartDate fields:** the maintainers note that some display tweaks may
> be needed to make the reset button work smoothly with SmartDate fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You enable the reset button
per field via a toggle in the field's widget settings on its *Manage form display*
tab.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage form display**: click the gear icon on a Date, Date/Time,
or Date range field and enable the option to show the **Reset** button. The button
then appears on that field in the content edit form.
