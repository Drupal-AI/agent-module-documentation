# Nice Filemime — manual setup guide

**Nice Filemime** (`nice_filemime`) replaces raw, technical MIME‑type strings with
friendly, human‑readable labels wherever file types are shown to your visitors. So
instead of a file that reads
`application/vnd.openxmlformats-officedocument.wordprocessingml.document`, users
see something like "Word document". It's a small display utility with no content
model or access role of its own — it simply improves how file types are presented.

The module provides three ways to surface the nicer labels. A **service** returns
the Nice Filemime description for any given MIME type, so developers can reuse the
mapping in custom code. A **field formatter** converts a MIME‑type value to its
"nice" counterpart automatically — handy in Views that list files. And a **facet
processor** does the same inside Search API / Facets, so a "file type" facet shows
readable labels instead of raw MIME strings.

Nice Filemime has no third‑party dependencies and supports Drupal 9, 10, and 11.
It stores a configurable mapping of MIME types to descriptions, but you apply it
by choosing the formatter or facet processor on the relevant display — there is no
central admin dashboard that changes site behaviour on its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Setup happens on the displays where file types appear (a Views field formatter or
a Facets processor), described in "How to use it" below.

## How to use it

Pick whichever surface matches where you want friendlier file‑type labels:

- **In a View that lists files** — edit the View, and on the field that outputs the
  file's MIME type choose the **Nice Filemime** field formatter. The raw MIME
  string is then rendered as its human‑friendly label.
- **In a Search API / Facets "file type" facet** — on the facet's processing
  settings, enable the **Nice Filemime** facet processor so the facet's values and
  labels read as friendly names.
- **In custom code** — call the Nice Filemime service to convert a MIME type to its
  description programmatically.

The mapping of MIME types to readable descriptions is configurable, so you can
adjust or extend the labels to match your site's language and audience.
