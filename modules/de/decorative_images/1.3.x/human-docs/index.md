# Decorative Image — manual setup guide

**Decorative Image** (`decorative_images`) lets content editors mark an uploaded
image as **purely decorative** — a spacer, a divider, a background flourish, a hero
image that adds no information — so it renders with `role="presentation"` and an
empty `alt` attribute and is skipped by screen readers. Not every image needs alt
text; forcing editors to invent it for decorative images actually clutters the
experience for assistive-technology users. This module gives them a clear switch
instead.

Site builders turn the feature on **per image field**. On the field's settings you
enable the decorative option, and you can optionally require that editors provide
**either** real alt text **or** the decorative flag — so an image can never be
saved with silently-missing alt. Once enabled, each image in the upload widget
gains a checkbox the editor can toggle.

The module is deliberately lightweight and hook-driven: it stores the decorative
flag out-of-band (in Drupal's key-value store, keyed by the image's file id) rather
than changing your field schema, and it handles both **node** and **media** image
fields. At display time it sets the presentation role and blanks the alt text
automatically. It requires core's Image module, adds no permissions, and has no
central settings page — configuration lives on each field.

This guide is written for a **human** configuring fields through the admin UI. If
you want terse, token-cheap references for an AI coding agent (the third-party
settings, the widget alter, and where the flag is stored), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the decorative option on an
   image field, the optional "Alt or Decorative" requirement, and the editor
   experience.

## Where it lives in the admin menu

There's no dedicated settings page. You enable and configure the feature on each
image field's **Edit field** form — for example **Structure → Content types →
*(your type)* → Manage fields → *(your image field)* → Edit** (and the equivalent
for Media types).

## How to use it

On an image field's *Edit field* form, tick **Enable the Decorative field** (and
optionally **Require Alt or Decorative**). Editors then see a per-image checkbox on
the upload widget; when they mark an image decorative, it renders with an empty alt
and `role="presentation"`. See [Configuration](configuration/index.md) for the
details.
