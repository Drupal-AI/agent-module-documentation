# Image Base64 Formatter — manual setup guide

**Image Base64 Formatter** (`image_base64_formatter`) adds a field formatter that
renders an image field as a **base64 data URI** instead of a URL — so the image
bytes travel *inside* the document rather than being fetched from a separate
address. Set it on an image field's *Manage display* (or on an image field in
Views) and choose "Image Base64" in place of the standard "Image" formatter.

There are a handful of places where a URL to an image is no good and the bytes have
to be present. The main one is **HTML email**: many clients block remote images by
default, so a logo referenced by URL simply does not appear, while an embedded one
does. **Self-contained documents** — an exported HTML report, a single-file
archive, a PDF-generation pipeline — need everything inline. So does anything
rendered where the recipient cannot reach the site, such as a REST/GraphQL payload
for a decoupled consumer or a third party who will not fetch from your domain.

> **Know the costs before you reach for it.** Base64 inflates image data by roughly
> a third, so a 300 KB photo becomes about 400 KB of text living *inside* the HTML.
> That text is **not cached separately** — the browser cannot reuse it across pages
> and re-receives it on every render of the containing document, whereas a URL is
> fetched once and cached for a long time. It also bloats the render-cache entry
> that holds it. This is the right tool for **small images in documents that must be
> self-contained**, and the wrong one for anything on an ordinary web page a browser
> will load normally.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no separate configuration page** for this module — it has no global
settings form. You configure it per field on *Manage display* (or in Views),
described in "How to use it" below.

## Where it lives in the admin menu

Image Base64 Formatter adds no admin page. You use it from **Structure → Content
types → *(your type)* → Manage display**, and from the Views UI for image fields.

## How to use it

1. Go to the **Manage display** tab of the entity with the image field you want to
   embed (or add the image field to a View).
2. In the **Format** dropdown, choose **Image Base64** instead of **Image**.
3. Click the gear icon to pick how the base64 image is emitted. Three output modes
   are available:
   - **Base64 String** — the raw base64-encoded string.
   - **Image Source** — the image rendered as an `<img>` tag whose `src` is the
     data URI.
   - **CSS background Source** — the value as `url('data:image/jpeg;base64,...')`,
     ready to drop into a CSS `background` property.
4. **Update** and **Save**. The image is now emitted inline in your chosen form.
