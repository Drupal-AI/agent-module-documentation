# Published and corrected dates — manual setup guide

**Published and corrected dates** (`published_corrected_date`) adds three
read‑only date/count properties to every node, aimed at newsrooms and editorial
sites that need to be precise about when an article was first published and when
it was last corrected. It's especially useful for journalism, where showing a
"Published" date and a separate "Last corrected" date is a matter of
transparency and, increasingly, SEO best practice.

The three properties it adds to all nodes are:

- **Publication date** — the first time the node was saved with its status set to
  *published*.
- **Last corrected date** — the most recent time the node was saved while
  published.
- **Number of corrections** — how many times the node has been saved while
  published, *not* counting that first publication.

These properties are maintained automatically. You **cannot edit them in the UI** —
they're computed from the node's save history. But they **are** available for
display via **Views** and **Layout Builder**, so you can surface them wherever
your theme or article template needs them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** and nothing to set up — the properties start
being recorded as soon as the module is enabled. See "How to use it" below.

## Where it lives in the admin menu

The module adds **no settings page**. Its output shows up where you choose to
display it: as fields in **Views**, or as blocks/fields in **Layout Builder**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). From that point
   on, the three properties are tracked automatically as nodes are published and
   re‑saved.
2. To show them on your site, add them where you build your display:
   - In **Views**, add the *Publication date*, *Last corrected date*, or *Number
     of corrections* fields to a content view.
   - In **Layout Builder**, place the corresponding fields into your node layout.
3. Format the dates as you would any date field (for example, "Published 3 June
   2024 · Last corrected 5 June 2024").

Because the values reflect real save history, existing nodes will populate their
publication and correction data going forward from when they're next saved while
published.
