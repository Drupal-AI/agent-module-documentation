# Current Year — manual setup guide

**Current Year** (`current_year`) is a tiny, lightweight module that outputs the
**current year** into a block of formatted text. Use it anywhere that accepts
formatted text — the body of a node, a block, and so on.

The classic case is a footer copyright line. Without a module like this, "© 2026"
has to be typed as literal digits and then remembered and updated every January —
and a site looks unprofessional when some copies of the year get missed. Current
Year makes the year dynamic: it renders at display time, so the copyright line is
always right. It's a safe display helper — the output is just a computed number,
with no user input involved.

It works by adding a **text‑format filter**. Once you've enabled the filter on a
text format, you type the token `&year;` in any text that uses that format, and it
is replaced with the current year when the text is displayed. There's **no
settings page** — the only setup is switching on the filter for the format(s) you
want. It works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you enable a text‑format
filter, as described in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the text format you want to use
   (for example *Full HTML* or *Basic HTML*).
3. In the list of **Enabled filters**, check **Display Current Year**.
4. If needed, adjust the **Filter processing order** so this filter runs at a
   point that doesn't conflict with others, and save.
5. Now, in any text using that format, type `&year;` where the year should appear
   — for example a footer copyright: `© &year; My Organisation`. When the text is
   rendered, the token becomes the current year.
