# Easy Responsive Images — manual setup guide

**Easy Responsive Images** (`easy_responsive_images`) takes the tedium out of
responsive images. Instead of hand-crafting a dozen image styles and a responsive
image style mapping, you fill in a single form — a minimum width, a maximum width, a
preferred step between sizes, and optionally some aspect ratios — and the module
generates a whole ladder of image styles for you. It then gives you a field
formatter and a Twig filter to output those styles, and a small piece of JavaScript
that loads the best-fitting image for the actual space each image occupies.

The generated styles are named with a `responsive_` prefix (for example
`responsive_600w` for a 600-pixel-wide scaled style, or `responsive_16_9_600w` for a
600-wide 16:9 crop). When you change the width range and save again, the module
prunes the styles it no longer needs, so your image-style list stays tidy. There is
also a button to delete all generated styles in one go.

To display images responsively you have two options: the **Easy Responsive Images**
field formatter, which you set on an image field and which emits a proper `srcset` of
all matching sizes; or the **`image_url`** Twig filter, for hand-built templates
where you want full control over the markup. On top of that it integrates with
next-gen image format modules (WebP, AVIF), with Focal Point for smart cropping, and
with Imagecache External for remote images — automatically serving better formats
when those modules are present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — generate the image styles, use the
   field formatter, and use the Twig filter in templates.

## Where it lives in the admin menu

- The generator lives under the **image styles** admin at
  **Configuration → Media → Image styles → Generate image styles**
  (`/admin/config/media/image-styles/generate`). It appears as a tab on the Image
  styles listing page.
- The generated styles show up alongside your other image styles at
  *Configuration → Media → Image styles* (`/admin/config/media/image-styles`), each
  prefixed `responsive_`.
- The **Easy Responsive Images** formatter is chosen per image field on a bundle's
  **Manage display** page.

## How to use it

At a high level: open the generator, enter a width range (and any aspect ratios),
save to create the styles, then either switch an image field to the Easy Responsive
Images formatter or use the `image_url` Twig filter in a template. Full step-by-step
instructions are in [Configuration](configuration/index.md).
