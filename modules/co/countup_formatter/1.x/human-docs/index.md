# CountUp Formatter — manual setup guide

**CountUp Formatter** (`countup_formatter`) adds a field formatter that animates a
numeric value, counting it up from zero to its final figure the moment it scrolls
into view. It is the classic "impact statistics" effect — *12,480 members*,
*98% uptime*, *3.2M downloads* ticking upward as a visitor reaches that section of
the page — applied cleanly as a display option rather than hand-written JavaScript.

The formatter works on **integer, float and decimal** fields, and you apply it the
same way you apply any other formatter: on an entity's *Manage display*. Behind the
scenes it wires up the third-party [countUp.js](https://github.com/inorganik/countUp.js)
library, which is **not bundled** with the module — you have to add it to your site's
`libraries/` folder yourself (see [Installation](installation/index.md)). Until that
library is present the animation will not run, so getting the library in place is the
one setup step that matters.

There is no site-wide settings page and no permissions to grant — the module simply
contributes a formatter. One thing worth keeping in mind is accessibility: a value
that animates is motion on the page, so consider visitors who prefer reduced motion
and confirm the effect reads well in your theme before shipping it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add the
   countUp.js library, and enable it.

There is **no configuration page** for this module. You choose the formatter on a
numeric field's *Manage display*, described below.

## How to use it

1. Make sure you have a number field to animate — an **integer**, **float** or
   **decimal** field on any content type, media type, or other fieldable entity.
2. Go to **Structure → (your entity type) → Manage display** for the bundle that
   holds the field.
3. In the **Format** column for that field, choose **CountUp** (the formatter this
   module provides).
4. Save the display, then view a page containing the field and scroll it into view —
   the number should animate from zero up to its value.

If the number appears but never animates, the countUp.js library is almost certainly
missing or in the wrong path — revisit [Installation](installation/index.md).
