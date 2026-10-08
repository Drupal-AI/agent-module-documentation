# Multivalue Field Restriction — manual setup guide

**Multivalue Field Restriction** (`multivalue_field_restriction`) limits **how
many values of a multi‑value field are displayed**, independently of the field's
cardinality. A field might store many items — a long list of tags, authors, or
images — and this module lets you cap how many of them actually appear in the
output, for example showing only the first three. The limit is applied **at
display time**, per view mode, so the field keeps storing every value while the
rendered output stays tidy.

The neat practical benefit the maintainers highlight is database economy: you can
set a field's cardinality to **unlimited** and then choose a display limit in the
front end. That way the same field can be reused across bundles without fiddling
with cardinality, and you avoid provisioning extra columns you do not need. It is
handy for teasers, compact listings, and summaries where showing every value
would clutter the page.

This is a **presentation‑only** feature. It changes what is rendered, not the
stored data and not access — all the values remain in the field and are still
reachable through display paths that do not apply this restriction. Configuration
is done entirely on a field's display settings, so there is no site‑wide
settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
set the limit per field display, described in "How to use it" below.

## How to use it

The limit lives on each field's **display** settings, so you set it wherever you
manage displays (you will want core's Field UI module enabled):

1. Go to the bundle whose field you want to cap — for example **Structure →
   Content types → *(your type)* → Manage display**.
2. Choose the **view mode** you want to affect (Default, Teaser, and so on) — the
   limit is per view mode, so you can show all values in full view and only a few
   in teasers.
3. Open the field's formatter settings and set the **number of values to
   display**. Save the display.

The field will now render only that many values in that view mode, while
continuing to store all of them.
