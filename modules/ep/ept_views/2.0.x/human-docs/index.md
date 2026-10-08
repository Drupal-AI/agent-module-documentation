# EPT Views — manual setup guide

**EPT Views** (`ept_views`) is one of the *Extra Paragraph Types* (EPT) family —
a set of small modules that each add a ready-made, styled paragraph type you can
drop into a page. This one adds a paragraph that **embeds an existing view**, so
an editor can place a listing (recent news, staff, related documents, an events
list) into the flow of a component-built page without building a new view display
for every placement. You keep one view definition; the editor decides where it
appears.

Like every EPT paragraph, it carries the family's shared *Design* options —
margins, paddings and borders (the "CSS box"), a background using colour, image
(including parallax and cover) or a YouTube video, and edge-to-edge or fixed
container width. It depends on the EPT core module (`ept_core`) and Paragraphs,
and it targets Drupal 10.1, 11 and 12.

A couple of things are worth planning before you hand it to editors. Views often
take **contextual arguments** (for example a taxonomy term to filter by); an
editor who enters the wrong argument gets an empty result that silently reads as
"there is no related content" rather than as a misconfiguration, so decide how
those arguments are supplied. The embedded view also brings **its own access and
cache metadata**, so the host page varies by whatever the view varies by. And
it's worth **deciding which views editors may embed**, since an unrestricted list
also includes administrative views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside EPT Core and Paragraphs.

There is **no configuration page** for this module. Each EPT paragraph is set up
per instance while you build a page, and the shared paragraph behaviour lives in
the **EPT Core** module ([`ept_core`](https://www.drupal.org/project/ept_core)) —
see its documentation for the family-wide design options.

## How to use it

Once the module is enabled, its paragraph type becomes available anywhere you have
added a Paragraphs field (typically the body/content builder field on a content
type). While editing content:

1. Add a new paragraph and choose the **EPT Views** type.
2. Select the view (and display) you want to embed, and supply any contextual
   argument the view needs.
3. Open the paragraph's **Design** options if you want to set spacing, a
   background, or the container width.
4. Save the content — the chosen view renders inline where you placed the
   paragraph.
