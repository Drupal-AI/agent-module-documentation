# Slick Entity Reference — manual setup guide

**Slick Entity Reference** (`slick_entityreference`) adds a Field UI display
formatter that renders a multi-value entity-reference field as a **Slick
carousel**. Each referenced entity — a node, taxonomy term, media item,
Paragraph, and so on — becomes a slide, rendered in whatever view mode you pick.
It's the no-code way to turn a "Related articles" or "Featured content" reference
field into a swipeable slideshow without building a Views display.

The module ships one primary formatter, **"Slick Entity Reference Vanilla"**
(`slick_entityreference_vanilla`), which applies to `entity_reference` and
`entity_reference_revisions` (Paragraphs) fields. A sibling formatter,
`slick_dynamicentityreference_vanilla`, does the same for
`dynamic_entity_reference` fields when that contrib module is installed. Both
formatters only appear on **multi-value** fields — a carousel needs more than one
item to rotate.

Importantly, the carousel's look and behavior — arrows, dots, autoplay, fade,
vertical mode, responsive breakpoints, skin, lazy-loading — is **not** configured
in this module. It comes from a **Slick optionset**, a config entity managed by
the Slick module at **Configuration → Media → Slick**
(`/admin/config/media/slick`). You just select which optionset the formatter
uses. A `default` optionset ships out of the box. Because the formatters build on
Slick (and Blazy underneath), they inherit Slick's settings: optionset, view
mode, optional thumbnail/navigation optionset, skin, and cache.

The module has **no settings form, no permissions, no services, and no Drush
commands** — all configuration is per-field, on the "Manage display" page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (Slick is
   required) and enable the module.

## Where it lives in the admin menu

There's no admin settings page for this module. You use it on the **Manage
display** tab of whichever entity/bundle owns your reference field — for example
**Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`). The Slick optionsets it draws
on are managed separately at **Configuration → Media → Slick**.

## How to use it

Before you start, make sure your reference field is **multi-value** (cardinality
greater than 1, or unlimited) — the formatter is hidden on single-value fields.

1. Install and enable the module and Slick (see
   [Installation](installation/index.md)).
2. Go to **Manage display** for the bundle that owns the reference field.
3. For that field, set **Format** to **"Slick Entity Reference Vanilla"**.
4. Click the formatter's settings gear and choose:
   - **Optionset** — which Slick optionset drives the carousel (its arrows,
     dots, autoplay, breakpoints, skin, and so on). Edit or create optionsets at
     `/admin/config/media/slick`.
   - **View mode** — how each referenced entity is rendered per slide (teaser,
     full, a custom card view mode, etc.).
   - Optional inherited Slick options — thumbnail/navigation optionset, skin,
     image style, cache.
5. Save.

That's it: the reference field now renders as a carousel. To change how the
carousel looks or behaves, edit the chosen **Slick optionset** rather than the
formatter. For Paragraphs, apply the formatter to the
`entity_reference_revisions` field (or consider the dedicated `slick_paragraphs`
module for richer image/overlay slides).
