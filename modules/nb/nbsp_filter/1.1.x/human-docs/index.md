# NBSP Filter — manual setup guide

**NBSP Filter** (`nbsp_filter`) is a text-format filter that manages non-breaking
spaces (`&nbsp;`) in your content — inserting them where typography needs them and
removing the stray ones editors accumulate. Non-breaking spaces are both a genuine
typographic requirement and a genuine editorial nuisance: French, for example,
requires a space before `; : ! ?`, and many style guides forbid a line break
between a number and its unit or a title and a surname — but editors pasting from
Word bring in hundreds of unwanted ones that defeat text wrapping and leave odd
gaps.

The module solves this at the right layer. Because it is a **filter**, it applies
at *render time* to all content — including migrated content and text submitted via
an API — where a WYSIWYG/CKEditor plugin would only affect what an editor types
after installation. You add it to whichever text formats need it and choose which
of its three actions to apply: remove all useless non-breaking spaces, convert a
space *before* configured punctuation to a non-breaking space, and convert a space
*after* configured punctuation to a non-breaking space.

It has no special requirements — it depends on Drupal core only and spans Drupal 8
through 11. Two things are worth keeping in mind: **filter order matters** (a filter
that runs after markup-restricting filters sees different text, so check its
position in the format's filter list if results look off), and inserting
non-breaking spaces changes the exact character sequence, so on a site with strict
search matching it is worth confirming how filtered output interacts with search.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page**. You configure NBSP Filter per text format
on the standard Text formats and editors screen, described in "How to use it"
below.

## Where it lives in the admin menu

NBSP Filter adds no page of its own. You enable and configure it per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the text format you want to affect (for example
   *Basic HTML* or *Full HTML*).
3. In the **Enabled filters** list, tick **NBSP Filter** to turn it on.
4. Scroll to the **Filter settings** section for NBSP Filter and review its
   options — whether to remove useless non-breaking spaces, and which punctuation
   marks should get a non-breaking space before and/or after them. Adjust the
   defaults to match your language and house style.
5. Check the **Filter processing order** tab. If markup-restricting filters run
   after NBSP Filter, they may alter what it produced — reorder if the output is
   not what you expect.
6. Click **Save configuration**. The rules now apply to all content rendered
   through that format.
