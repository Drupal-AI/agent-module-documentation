# Input add more attributes — manual setup guide

**Input add more attributes** (`input_pattern`) lets you set extra HTML
attributes on form input elements from configuration — without writing custom
code. It is aimed at the HTML5 attributes that shape how a browser treats a
field: `pattern` (a regular expression the value must match), `min`, `max`,
`step`, `minlength`, `placeholder`, `class`, `inputmode`, and similar.

Its most useful trick is with number and phone-number fields, where a
**separator** and a **step** turn raw digits into readable, grouped input as the
user types. For example, a phone field with a space separator and a step of 2
guides input into `01 23 45 67 89`; a number field with a space separator and a
step of 3 shows `10 00 000`. This makes long numeric entries far easier to read
and reduces mistyped values.

Because these are HTML5 attributes, the effect is **client-side** — they improve
the editing experience and provide browser-level hints and validation. As with
all client-side validation, treat it as a convenience for the person filling in
the form, not as a security boundary: anything that matters must still be
validated server-side. The module supports Drupal 10, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module. You add the attributes on
the individual field where you want them, through Drupal's Field UI, as described
below.

## How to use it

The attributes are configured **per field**, on the form-display side of the
Field UI:

1. Go to **Structure → Content types → *(your type)* → Manage form display**
   (or the equivalent Manage form display for any other fieldable entity).
2. Find the field you want to enhance and open its widget settings (the gear/cog
   icon at the end of its row).
3. Set the additional attributes you need — for example a `pattern` regular
   expression, or a separator and step for a numeric or phone field.
4. Save the form display, then add or edit a piece of content to see the
   attributes and grouped-input behavior applied in the form.

Because the settings live on each field individually, you can tune validation and
input hints exactly where they are needed and leave other fields untouched.
