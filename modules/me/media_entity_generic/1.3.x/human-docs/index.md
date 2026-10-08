# Media Entity Generic — manual setup guide

**Media Entity Generic** (`media_entity_generic`) adds a single "Generic" media
source to Drupal's core Media system. A media *source* is what tells a media type
where its content comes from — an image file, a remote video URL (oEmbed), a
document, and so on. The Generic source is the plainest possible option: it stores
an arbitrary **text string** as the media's value and shows a generic placeholder
thumbnail.

The module exists mainly as an **upgrade bridge**. Sites that used the old
contributed *Media Entity* 1.x module's "Generic" provider need an equivalent when
they move to Media in core (Drupal 8.4+), and this module provides it — during that
upgrade it is enabled automatically. On a modern site you can also enable it
deliberately when you want a bare-bones media type whose "content" is just a text
value: a reference code, an external asset ID, a SKU, a catalog number, or a
placeholder while you decide on a real source later.

It is deliberately tiny. There is no settings form, no permissions of its own, no
Drush commands — just the one source plugin. It depends only on core's **Media**
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — enable the module (Composer is optional
   for a bridge that is often already present).

## Where it lives in the admin menu

The module adds **no page of its own**. Its only footprint is a new choice —
**Generic media** — in the **Media source** drop-down when you create or edit a
media type at **Structure → Media types**
(`/admin/structure/media/add`).

## How to use it

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give the type a name and, under **Media source**, choose **Generic media**.
3. Save. Core creates a plain **string** source field for the type — that field
   holds the text value each media item stores.

From then on, editors create media of that type and type a text value into the
source field. Every item of the type shares the same generic placeholder thumbnail,
and the source surfaces no derived metadata (no width, height, or duration), because
its value is simply text.
