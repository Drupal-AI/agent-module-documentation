# Background Image Field — manual setup guide

**Background Image Field** (`bg_img_field`) gives you a field type for
**responsive CSS background images**. Instead of adding an image field and then
writing theme CSS to place that image as a `background-image`, you add a
Background Image field, upload a picture, and tell it which CSS selector to target
(for example `.hero` or `#banner`). At display time the module renders a `<style>`
block that sets that selector's `background-image`, complete with `@media` queries
for each breakpoint of a responsive image style — so the browser downloads an
appropriately sized image (including retina/2x variants) for each viewport.

It is a complete field trio built on core's Image and Responsive Image modules: a
**field type**, a **widget** for editors, and a **formatter** for display. Beyond
the image upload, each item stores four CSS properties the editor can set —
the **selector**, **background‑repeat**, **background‑size**, and
**background‑position** — so a single reusable field replaces a pile of bespoke
image fields plus theme CSS. The selector supports **tokens** from the host
entity, and a media source (`bg_img_media_field`) lets the field back a Media
type. On Layout Builder section routes the CSS is rendered through a dedicated
template; everywhere else it is injected into the page `<head>`.

There is no global settings page and the module adds no permissions of its own —
you set everything up per field through Field UI, and content editors set
per‑item values through the widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Responsive Image and Token.

## Where it lives in the admin menu

There's no dedicated admin page. You work with the field in the usual field
places: **Structure → (your entity) → Manage fields** to add it, **Manage form
display** for the widget, and **Manage display** to pick the responsive image
style. Responsive image styles themselves are created at **Configuration → Media →
Responsive image styles**.

## How to use it

### 1. Create a responsive image style first

The formatter renders images through a responsive image style, so you need one
before the field can show anything. Go to **Configuration → Media → Responsive
image styles** and create a style whose breakpoint mappings each point at a single
image style. (Only responsive image styles that map to a single image style are
offered by the formatter — "sizes"‑type styles are not listed.)

### 2. Add the field

In **Manage fields** for any entity/bundle, add a field of type **Background
Image**. In the field settings you can:

- Adjust the **allowed file extensions** (default `png jpg jpeg svg` — add `webp`
  if you like).
- Set **field‑level default** values for the CSS selector, repeat, size, and
  position. Alt/title text is intentionally dropped, since background images are
  treated as decorative.

### 3. Configure the widget (optional)

On **Manage form display**, the widget has a **Hide CSS Settings** option. This
visually hides the per‑item CSS controls from editors while still applying the
field defaults. (Note the fields remain present and submittable even when hidden.)

### 4. Set the formatter

On **Manage display**, choose the field's formatter and pick your **Responsive
image style**. That's the style whose breakpoints drive the generated media
queries.

### 5. Add content

When editing content, upload an image and — unless the CSS settings are hidden —
fill in the **CSS selector** (a token tree is available so you can include, say,
the entity ID) and choose the repeat, size, and position. On save, the front end
renders the responsive background CSS for that selector.
