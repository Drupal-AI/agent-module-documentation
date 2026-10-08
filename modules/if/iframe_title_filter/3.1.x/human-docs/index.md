# iFrame Title Filter — manual setup guide

**iFrame Title Filter** (`iframe_title_filter`) fixes a common accessibility
problem: embedded `<iframe>` tags — YouTube videos, maps, third‑party widgets —
that are missing a `title` attribute. Screen readers rely on that title to describe
the frame, and its absence is a frequent WCAG/Section 508 audit failure. This module
adds a sensible `title` automatically to any iframe that doesn't already have one,
so you don't have to hand‑edit every embed.

It works in two complementary ways. First, it provides a **text‑format filter**,
"Add missing titles to iFrames," that you enable on whichever text formats your
editors use. When content is rendered, the filter scans the HTML for title‑less
iframes and sets each one's title to "Embedded content from *host*," where *host*
comes from the iframe's `src` URL. Author‑supplied titles are always left untouched —
only the missing ones are filled in. Second, it integrates with core **Media**'s
oEmbed embeds (YouTube, Vimeo, and so on), titling those iframes with the oEmbed
resource title, or "Embedded content from *provider*" as a fallback — no
configuration needed for that part.

Because the filter operates on the final rendered markup, the one thing to get right
is **ordering**: place it after any filter that generates or corrects iframe HTML
(such as Media embed or video_filter) so it sees the finished iframes. There is no
global settings page, no permission, and no dependencies beyond core. It works on
Drupal 10.1, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enabling the filter on a text format
   and ordering it correctly.

## Where it lives in the admin menu

There is no settings page of its own. You turn the filter on per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). The Media oEmbed titling works automatically once
the module is enabled.

## How to use it

Enable the module, then edit each text format where editors embed iframes and tick
**Add missing titles to iFrames** — dragging it below your HTML/iframe‑generating
filters. See [Configuration](configuration/index.md) for the step‑by‑step.
