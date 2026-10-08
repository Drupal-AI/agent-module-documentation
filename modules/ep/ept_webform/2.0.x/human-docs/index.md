# EPT Webform — manual setup guide

**EPT Webform** (`ept_webform`) is part of the *Extra Paragraph Types* (EPT)
family — small modules that each add a ready-made, styled paragraph type. This one
adds a paragraph that **embeds a webform into the flow of a page**, so a form can
sit as one component among several — a landing page whose sequence is hero, text,
form, testimonials, for example. It's the paragraph-shaped way to place a form,
which is the right fit when the form is a component whose *position* on the page
matters (as opposed to a webform reference field, a placed block, or an extra
field, which suit other situations).

Like every EPT paragraph, it carries the family's shared *Design* options —
margins, paddings and borders, a background using colour, image (including
parallax and cover) or a YouTube video, and edge-to-edge or fixed container width.
It depends on the EPT core module (`ept_core`), Paragraphs, and the Webform
module, and it targets Drupal 10.1, 11 and 12.

Two things are worth knowing before you give editors a form they can drop
anywhere. A form on a page **changes how that page caches** — a webform carries a
build id and a CSRF token, so a page containing one cannot be served from the
anonymous page cache in the usual way, which matters on a high-traffic landing
page. And **submissions need context**: the same form placed on a dozen landing
pages produces indistinguishable submissions unless the host page is recorded with
them, so confirm the paragraph passes the host entity into the submission if you
need to know which page generated a lead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside EPT Core, Paragraphs and Webform.

There is **no configuration page** for this module. Each EPT paragraph is set up
per instance while you build a page, and the shared paragraph behaviour lives in
the **EPT Core** module ([`ept_core`](https://www.drupal.org/project/ept_core)) —
see its documentation for the family-wide design options.

## How to use it

Once the module is enabled, its paragraph type becomes available anywhere you have
added a Paragraphs field. While editing content:

1. Build the form you want first in **Structure → Webforms** (or reuse an existing
   one).
2. In your content, add a new paragraph and choose the **EPT Webform** type.
3. Select the webform to embed.
4. Open the paragraph's **Design** options if you want to set spacing, a
   background, or the container width.
5. Save the content — the form renders inline where you placed the paragraph, and
   the webform keeps its own handlers, validation and access rules.
