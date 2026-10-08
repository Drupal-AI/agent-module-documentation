# Inputmask Widget — manual setup guide

**Inputmask Widget** (`inputmask_widget`) provides a field widget that applies an
**input mask** to text fields — enforcing a format as the user types. Instead of
letting people enter a phone number, date, or currency amount in any shape they
like, the widget guides them into the pattern you choose, so the data arrives
clean and consistent.

It uses the well-known Inputmask JavaScript library to do the masking. Typical
uses are phone numbers, dates, times, postal codes, and currency — anywhere a
field has a predictable shape you want to enforce at entry time. The module works
on top of core's **Text** field type and lives in the Field Types package.

One thing to keep in mind: the mask is a **client-side convenience**. It makes the
form easier to fill in correctly, but it is not a security or data-integrity
guarantee — for anything that matters, still validate the value server-side. The
module supports Drupal 8.9, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module. You choose the widget and
set its mask on the individual field, through Drupal's Field UI, as described
below.

## How to use it

The mask is configured **per field**, on the form-display side of the Field UI:

1. Add (or reuse) a text field on your content type — for example a "Phone"
   field. Go to **Structure → Content types → *(your type)* → Manage fields**.
2. Switch to **Manage form display** for that content type.
3. For your text field, change the **Widget** to the Inputmask widget.
4. Open the widget's settings (the gear/cog icon) and enter the mask that matches
   the format you want — a phone-number mask, a date mask, a currency mask, and so
   on.
5. Save the form display, then add or edit content and confirm the field now
   guides input into the chosen format as you type.
