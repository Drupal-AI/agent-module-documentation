# Entity Attributes Field (EAF) — manual setup guide

**Entity Attributes Field** (`eaf`) adds a new **field type** for attaching custom
*attributes* to entities, fields, or individual field items. Attributes are extra
metadata or configuration — not part of the main content, but settings that shape
how content behaves or displays. Think alignment options for an image (left, right,
center), a "hide title" or "include in table of contents" toggle on a paragraph, a
background colour choice for a section, spacing/padding options, "render this link
as a button", or a custom CSS class chosen from a taxonomy vocabulary.

The idea is to keep this kind of customisation *out* of your content model. Rather
than adding a scatter of small boolean and select fields to every content type, you
add one EAF field and configure which **attribute plugins** are available on it.
Editors then pick and configure the attributes they want per item, and the data is
stored compactly as JSON. Attributes aren't meant to be searched, indexed, or shown
as primary content — they exist to enhance display and behaviour.

EAF is built around reusable **attribute plugins**: small pieces of code that each
define one attribute and how it behaves. That makes attributes reusable across many
content types and fields, and lets developers add their own plugins for
project‑specific needs. The module works on Drupal 10 and 11 and depends only on
core. Values follow Drupal's normal field sanitisation on display, and the module
has no content‑access role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — you set EAF up per field, using
Drupal's own Field UI, as described below.

## How to use it

1. On the entity type or bundle you want to enhance (a content type, a paragraph
   type, users, etc.), go to **Manage fields** and **add a field** of the **Entity
   Attributes Field** type.
2. In the field's settings, **configure which attribute plugins** are available for
   this field or entity — the set of attributes editors will be able to choose from.
3. When creating or editing content, editors **select and configure** the available
   attributes for that item. The choices are saved as JSON on the entity.
4. Use the stored attribute data in your theme/templates or via other modules to
   drive the display or behaviour it represents (alignment, background, a CSS class,
   and so on).

> **Tip:** Because attributes are metadata rather than content, plan them as
> presentation/behaviour options — the kinds of choices you'd otherwise hard‑code in
> a template or bolt on as one‑off fields.
