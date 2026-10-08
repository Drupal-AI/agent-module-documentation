# Paragraphs List Filter — manual setup guide

**Paragraphs List Filter** (`paragraphs_list_filter`; the project's human-readable
name is *paragraph_type_list_filter*) is a small usability improvement for sites
that use a lot of paragraph types. When you build heavily with Paragraphs, the
list of paragraph types can grow long, and finding the right one — whether you're
browsing the admin listing or picking a type — turns into a lot of scrolling.
This module adds **filtering** to that experience so you can narrow the list down
quickly.

You can filter by **machine name** (handy if you know the technical identifier),
by **label** (the visible human name), and by **description**. That makes it
faster for both developers and content editors to locate the exact paragraph type
they need, which speeds up content building and cuts down on picking the wrong
one.

It's purely an administrative and editorial convenience layered on top of the
paragraph-type listing — it targets the *list of types*, not the content
paragraphs themselves, and it has no access-control implications. It depends on
the **Paragraphs** module and supports Drupal 9 through 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. The filters appear
automatically once it is enabled.

## How to use it

1. Make sure the **Paragraphs** module is enabled.
2. Enable Paragraphs List Filter (see [Installation](installation/index.md)).
3. Where you work with paragraph types (browsing the paragraph-type list or
   selecting a type), use the filter controls to narrow the list by machine name,
   label, or description. Type or pick a value and the list shrinks to the
   matching types — no more scrolling through the full set.
