# Image Link Formatter — manual setup guide

**Image Link Formatter** (`image_link_formatter`) adds a new image field
formatter called **"Image wrapped within link field"** that renders each image
wrapped in a link whose URL comes from a **Link field** on the same entity. In
other words, it turns images into clickable banners or ads that point wherever an
editor decides — a campaign landing page, a partner site, an external store — all
without any custom Twig or preprocessing.

Rather than reinventing image display, it *extends* core's image formatter, so you
keep every familiar option (image style, "Link image to Content/File/Nothing") and
simply gain your entity's Link fields as extra choices in the existing **"Link
image to"** dropdown. When you pick a Link field there, each image is paired with a
link **by delta** — the first image wraps the first link, the second image the
second link, and so on. If a link is empty for a given image, that image is left
unwrapped.

Because it builds on core, it works anywhere you have an image field and a link
field on the same thing: nodes, custom blocks, users, taxonomy terms, media, and
Paragraphs. And because link options travel on the link value, companion modules
like **Link Attributes** or **Link Target** let those image links open in a new tab
(`target="_blank"`) or carry `rel` attributes automatically. A submodule,
**Responsive Image Link Formatter**, does the same trick for core's Responsive
Image formatter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the responsive submodule.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the formatter on each bundle's
**Manage display** page — for example **Structure → Content types → Article →
Manage display** (`/admin/structure/types/manage/article/display`).

## How to use it

1. Make sure the bundle has **both** an image field and at least one **Link field**
   (the Link field supplies the destination URL). Add a Link field if you don't
   have one.
2. Go to the bundle's **Manage display** page for the view mode you want (Default,
   Teaser, etc.).
3. For the **image field**, change the format to **"Image wrapped within link
   field"**.
4. Click the field's settings cog. In the **"Link image to"** dropdown you'll now
   see your entity's Link fields listed (as *Label (field_machine_name)*) alongside
   the usual Content / File / Nothing options. Choose the Link field whose URL
   should wrap the image.
5. Click **Update**, then **Save**. The summary will read "Linked to *your Link
   field label*."

From then on, each image renders wrapped in a link to the matching Link field
value. If you need multiple images each pointing somewhere different, add several
values to both fields — they pair up in order. To get the same behavior with
responsive images, use the Responsive Image Link Formatter submodule instead (see
[Installation](installation/index.md)).
