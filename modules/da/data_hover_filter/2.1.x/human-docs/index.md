# Data hover Filter — manual setup guide

**Data hover Filter** (`data_hover_filter`) is a small text‑format filter that
automatically adds a `data-hover` attribute to every link in your content, using
the link's own text as the value. So a link written as *Link to Drupal* comes out
of the filter carrying `data-hover="Link to Drupal"`. On its own that changes
nothing visible — but it gives your theme's CSS or JavaScript a hook to build
fancy hover effects and tooltips (for example, duplicating the link text on
`:hover` via a CSS `content: attr(data-hover)` rule).

It is deliberately tiny: no other module dependencies, no external libraries, and
support spanning Drupal 8 all the way through 12. There is nothing to build or
wire up beyond turning the filter on for the text formats where you want it.

Because it is a **text‑format filter**, you do not configure it on a settings page
of its own — you enable it on one or more of your existing text formats (Basic
HTML, Full HTML, and so on). Once enabled on a format, every piece of content
using that format gets the `data-hover` attribute added to its links
automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated configuration page** — you switch the filter on within
each text format, as described under "How to use it" below.

## Where it lives in the admin menu

You turn the filter on from **Configuration → Content authoring → Text formats
and editors** (`/admin/config/content/formats`) — there is no separate settings
page for the module itself.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**.
2. Click **Configure** next to the text format you want to affect (for example
   *Basic HTML*).
3. Under **Enabled filters**, tick the Data hover Filter option.
4. If your site cares about filter order, drag the filter into the right position
   in the **Filter processing order** section (place it so it runs after the
   HTML is in place).
5. Click **Save configuration**.

From then on, links in any content that uses that text format are rendered with a
`data-hover` attribute mirroring the link text — ready for your theme's CSS or
JavaScript to use.
