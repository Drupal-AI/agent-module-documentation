# Contextual Image Widget Crop — manual setup guide

**Contextual Image Widget Crop** (`contextual_image_widget_crop`) makes the
[Image Widget Crop](https://www.drupal.org/project/image_widget_crop) cropping UI
smarter inside the **Media Library** workflow. It looks at the *context* of the
entity a Media image is being added to, and only exposes the crop types that
context actually needs — instead of showing an editor every crop type configured
on the site.

The problem it solves is an everyday editorial annoyance. Say you have a
"blogpost" content type with a Media reference field for the teaser image, and its
**Manage display** shows that image through an image style using a 4:3 crop type.
When an editor adds a Media image to a blog post, the only crop that matters is
4:3 — every other crop type on the site is noise. This module hides the irrelevant
crop types and presents only the ones that apply in that context, keeping the
editor's workflow clean and focused.

It builds directly on **Image Widget Crop** and core's **Media Library**, so both
must be present. The crop types themselves are still defined through the Crop API /
Image Widget Crop setup as usual; this module does not add its own settings page —
it simply surfaces the right crops, contextually, when editors work with media.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Media Library and Image Widget Crop dependencies.

There is **no configuration page** for this module. Crop types and image styles
are configured in the usual places, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. It works within the existing Media / Image Widget
Crop configuration:

- **Crop types** live at **Configuration → Media → Crop types**
  (`/admin/config/media/crop`).
- **Image styles** (where you attach a crop effect to a crop type) live at
  **Configuration → Media → Image styles** (`/admin/config/media/image-styles`).
- The crop UI itself appears in the Media Library when editors add or edit an
  image on a fielded entity.

## How to use it

1. Define your crop types and the image styles that use them (Crop API / Image
   Widget Crop), as you normally would.
2. On the host entity's **Manage display** (for example your blog post content
   type), configure the Media image field to use an image style backed by the
   crop type you want editors to control.
3. When an editor adds a Media image to that entity through the Media Library, the
   crop UI will offer only the crop type(s) relevant to that context, rather than
   every crop type on the site.
