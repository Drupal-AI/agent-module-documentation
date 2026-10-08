# Color Field from image — manual setup guide

**Color Field from image** (`color_field_from_image`) automatically fills a **Color
Field** with the **dominant color** extracted from an image field on the *same*
entity. So a card, teaser, or background can be tinted to match its own image
without anyone picking a color by hand. The color is computed whenever the entity is
saved.

It is a small field-automation helper with no content or access role of its own. It
builds on the contributed **Color Field** module (which provides the color field it
populates) and core **Image** (which provides the source image field). It supports
Drupal 10.1+, 11, and 12.

The setup is done entirely through the Field UI: you add a Color Field to an entity
that already has an image field, then enable the "Color Field from image" behavior on
that Color Field and point it at the image field to read from. There is no separate
settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Color Field.

There is **no configuration page** — the behavior is enabled on the field itself,
described in "How to use it" below.

## How to use it

1. Make sure the entity (content type, media type, etc.) already has an **image
   field**.
2. On that bundle's **Manage fields**, add a **Color Field** type field (from the
   `color_field` module).
3. In the new field's settings, enable the **"Color Field from image"** behavior and
   select the **image field** it should read the dominant color from.
4. Save. The next time an entity of that bundle is saved, the Color Field is
   populated with the dominant color of the image.
