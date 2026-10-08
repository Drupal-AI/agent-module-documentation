# Library attach — manual setup guide

**Library attach** (`library_attach`) lets your *content* declare which asset
libraries a page needs, through a **text‑format filter**. When a snippet in the
body requires a particular script or stylesheet — a chart, a map, a lightbox — the
filter attaches that library only where it is used, instead of the theme loading
it on every page.

This is the pragmatic middle ground between two familiar approaches. Loading a
library site‑wide in the theme is simple but forces the payload onto the hundreds
of pages that don't need it. Building a custom formatter or a dedicated paragraph
type for each case is the clean answer but is a development task every time. A
filter that reads a marker in the content sits between the two: content declares
its own dependency, and Drupal's asset system does the rest — keeping the library
inside proper **aggregation and dependency ordering** rather than a raw
`<script>` tag pasted into the body.

The way it works is that a library declares a `filter-selector-css` or
`filter-selector-xpath` in its `*.libraries.yml`, and when the filter finds a
matching selector in the rendered text it attaches that library to the page.

> **Security note worth stating plainly:** attaching a library means loading
> JavaScript, so whoever can put the marker in content can cause a script to run
> on the page. The set of attachable libraries should be an **administrator‑set
> allow‑list**, not a name taken from the content. Before enabling the filter on a
> text format that non‑trusted users can use, confirm which libraries it will
> attach, and treat the filter's configuration as an administrative surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core's Filter module.

There is **no dedicated settings page** for this module — you set it up as a
filter on an existing text format, described below.

## Where it lives in the admin menu

You configure Library attach on your text formats at **Configuration → Content
authoring → Text formats and editors**
(`/admin/config/content/formats`). Edit the format you want and enable the
Library attach filter in its filter list.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   a text format (for example *Full HTML*, or better, a format reserved for
   trusted editors).
2. In the **Enabled filters** list, tick the Library attach filter, and review its
   position and settings in **Filter processing order** / the per‑filter settings
   below.
3. Ensure the libraries you want to be attachable declare a `filter-selector-css`
   or `filter-selector-xpath` in their `*.libraries.yml`.
4. When editors add matching markup to content using that format, the relevant
   library is attached automatically — only on the pages that contain it.
