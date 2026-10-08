# Enhanced Image Formatter — manual setup guide

**Enhanced Image Formatter** (`enhanced_image_formatter`) replaces Drupal's
default image field formatter with an enhanced version that can do three things
the core formatter cannot: generate **ALT and TITLE text from tokens**, **link
the image** to its host entity or to a URL stored in a link field, and render
**SVG images**. It builds on the [SVG Image](https://www.drupal.org/project/svg_image)
and [Token](https://www.drupal.org/project/token) modules, which it requires.

The important thing to understand is that it does not add a new formatter you pick
from a list — it **takes over the core `image` formatter itself**. Once the module
is enabled, every image field that uses the "Image" formatter gets the enhanced
behaviour site-wide, and the extra options appear in that formatter's settings
under **Manage display**. (The module raises its own weight on install so its
changes apply after SVG Image's, inheriting SVG rendering.)

That makes it powerful for accessibility and SEO: you can, for example, generate
meaningful alt text for many images at once from the node title or a field value,
rather than writing it by hand each time. The ALT/TITLE templates you enter are
administrator-controlled and are sanitized before they become HTML attributes, so
there is no raw-output path to worry about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its SVG Image / Token dependencies.

There is **no separate settings page** for this module. Its options live in the
**Manage display** settings of each image field, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it under **Structure → Content
types → *(your type)* → Manage display** (or the Manage display tab of any
fieldable entity), in the settings of an image field.

## How to use it

Because the module reuses the core `image` formatter, there is nothing to switch
on per field — but you should **review your existing image displays after enabling
it**, since the change is site-wide.

1. Go to the **Manage display** tab of a content type (or other bundle) that has
   an image field.
2. Open the image field's formatter settings (the gear icon). Alongside the
   standard and SVG options you now have:
   - **Tokenized ALT and TITLE** — an *Alternative text* field and a *Title text*
     field that accept tokens (up to 255 characters each), with a token-tree
     helper to discover available tokens. At render time the tokens are replaced
     using the host entity as context (unreplaced tokens are cleared), the result
     is sanitized, and it becomes the image's `alt` / `title` attribute.
   - **Image link** — in addition to the usual "content" and "file" targets, you
     can link the image to the URL stored in any **link field** on the same
     entity/bundle.
3. Save the display.

> **Tip:** for taxonomy term images, the token type is mapped to *term*, so pick
> term tokens from the token tree.
