# Media Responsive Thumbnail URL Formatter — manual setup guide

**Media Responsive Thumbnail URL Formatter** (`media_responsive_thumbnail_url_formatter`)
adds a field formatter for **media-reference fields** that outputs the *URL* of a
media entity's responsive thumbnail — not a rendered `<img>` tag. You pick which
responsive image style to use, and the formatter prints the resulting derivative
URL as plain text.

That makes it handy in decoupled or JavaScript-driven front ends, and in Twig
templates where you want to build your own markup (a `background-image`, a
`srcset`, a JSON payload) from the thumbnail URL rather than accept Drupal's
default image rendering. It depends only on core **Media**.

Because it emits a URL, the underlying media and its image derivative still respect
normal file access — the formatter adds no access-control behavior of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media dependency.

This module has **no configuration page**. You select and configure the formatter
entirely on a field's *Manage display*, as described under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(bundle)* → Manage display** (or the Manage display tab of any fieldable entity
that has a media-reference field).

## How to use it

1. Add a **media reference** field to a content type or other entity, if you don't
   already have one.
2. Go to that entity's **Manage display** tab.
3. For the media field, choose **Responsive thumbnail url** as the format.
4. Open the formatter's settings (the gear icon) and pick the **responsive image
   style** to use for the thumbnail.
5. Save. The field now renders the URL of the thumbnail at the chosen responsive
   image style, ready for your template or front end to consume.
