# Paragraphs Responsive Background Image Formatter — manual setup guide

**Paragraphs Responsive Background Image Formatter**
(`paragraphs_responsive_background_image_formatter`) provides a field **formatter**
that renders a media image as a **responsive CSS background** on a Paragraph.
Instead of showing an image inline, it outputs responsive `background-image` CSS
(building on the BG Image Formatter module) so a Paragraph section can carry a
full-bleed, responsive background behind its content — the classic "hero" or
"section with a background photo" pattern.

The formatter gives you one key choice: the **DOM element target**. Set it to
**Paragraph** and the background is applied to the paragraph container, painting
behind all the paragraph's child elements — ideal for full-screen background
sections. Set it to **Media field element** and the background is applied to the
media field element itself — useful for smaller, inline background elements.

The image is a media item chosen by an editor or admin, and the module is purely a
display/theming feature with no content or access-control role. It depends on core
**Media**, the **Paragraphs** module, and the **BG Image Formatter** module (whose
responsive background handling it extends). It supports Drupal 9.3 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   BG Image Formatter dependency) and enable the module.

There is **no configuration page** for this module. You choose and configure the
formatter on a Paragraph's image field under *Manage display*, as described below.

## Where it lives in the admin menu

The module adds no settings screen. You use it from **Structure → Paragraph types
→ *(type)* → Manage display**, where you set the formatter for the media image
field.

## How to use it

1. Make sure the **Paragraphs**, **Media**, and **BG Image Formatter** modules are
   enabled, then enable this module (see [Installation](installation/index.md)).
2. Create (or open) a paragraph type and add a **media** field to it for the
   background image.
3. In the paragraph type's **Manage display**, set that media field to be rendered
   as **rendered entity**.
4. Create or edit the referenced media type's image display and choose
   **Paragraphs Responsive Background Image** as the image formatter.
5. Set the formatter's **DOM element target** to either **Paragraph** (background
   on the whole paragraph container — good for full-screen sections) or **Media
   field element** (background on the media field element — good for inline
   backgrounds).
6. Add the paragraph to your content, choose a background image, and the section
   renders with a responsive CSS background.
