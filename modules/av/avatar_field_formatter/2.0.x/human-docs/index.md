# Avatar Field Formatter — manual setup guide

**Avatar Field Formatter** (`avatar_field_formatter`) is a small display tool. It
adds a new **field formatter** for image fields that renders the image as an
avatar — a consistent, avatar‑styled thumbnail — rather than as a plain image.
Typical uses are author bylines, comment authors, and member listings, where you
want every picture to appear at the same size and shape.

It works on any image field, including Drupal's built‑in **user picture** field.
Because it is a display‑layer feature, it changes only how the image is presented;
it does not alter the stored file in any way. It has no pages, permissions, or
services of its own, and no dependencies beyond core's Image and Field.

You choose the avatar presentation (size/shape) per view mode, so different
displays can show different avatar sizes — a large avatar on a profile page, a
small one in a comment thread. It works alongside core image styles for the actual
cropping and resizing, and falls back gracefully when a field has no image.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no admin settings page — you configure it directly on the field whose
display you want to change:

1. Go to the **Manage Display** tab for the entity and view mode you care about
   (for example a content type's Teaser display, or *Configuration → People →
   Account settings → Manage Display* for the user picture).
2. For the image field, choose the **Avatar** formatter from the format
   drop‑down.
3. Click the gear icon to set the formatter's options (such as the image size /
   style) and save.
4. Clear caches if the change does not appear immediately, so the display
   rebuilds.

Tip: keep your image styles defined and, if you like, pair the field with a
default/placeholder image so empty values still show a tidy avatar.
