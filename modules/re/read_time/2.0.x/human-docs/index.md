# Read time — manual setup guide

**Read time** (`read_time`) calculates and displays how long a piece of content
will take to read — the familiar "5 min read" line that has become standard on
articles, blogs, tutorials, and documentation. Setting that expectation up front
helps readers decide whether to read now or save for later, which is why so many
publishing platforms show it.

The module adds a **pseudo-field** to your content types that you can show or hide
from the **Manage display** page, just like any other field. The estimate is a
word count divided by an assumed reading speed, and Read time lets you configure
which fields are counted, the assumed reading speed, the display format, and any
extra text (such as a label) to show alongside the figure. Because it is a field
you place on a display, the read-time line can appear consistently wherever
content is rendered — full pages, teasers, listings — rather than only where
someone remembered to add it by hand.

Two honest caveats worth keeping in mind: the assumed words-per-minute is a
**convention, not a measurement** (the usual 200–250 wpm comes from studies of
adults reading prose, so technical content, tables, and code will read more
slowly and your estimates will run optimistic), and **what counts as a word**
matters — whether images, captions, and embedded media are included changes the
answer noticeably on a picture-heavy article.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — place the read-time pseudo-field and
   tune the calculation, field by field.

## Where it lives in the admin menu

Read time has no central settings page. You enable and tune it per content type on
its **Manage display** tab (**Structure → Content types → *(type)* → Manage
display**), where the read-time pseudo-field and its settings appear.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On a content type's **Manage display**, drag the **Read time** pseudo-field out
   of the *Disabled* section into a visible region.
3. Open its settings (the gear icon) to choose which fields feed the calculation,
   the reading speed, the display format, and any label — see
   [Configuration](configuration/index.md).
4. Save the display and view a piece of that content to see the read-time line.
