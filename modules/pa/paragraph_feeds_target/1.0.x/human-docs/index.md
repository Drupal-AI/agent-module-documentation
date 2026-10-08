# Paragraph Feeds Target — manual setup guide

**Paragraph Feeds Target** (`paragraph_feeds_target`) lets a **Feeds import
populate paragraphs**. It provides a Feeds *target* plugin that maps values from an
imported feed directly into the sub‑fields of paragraph entities, so an import can
create and fill in structured paragraph content on a host node (or any other
fieldable entity) without you writing any custom code.

Under the hood it registers a Feeds target for every *entity reference revisions*
(paragraph) field on the bundle you are importing into. It looks at the paragraph
bundles that field allows and exposes **every sub‑field of every allowed bundle** as
an individual mapping target, so on the Feeds mapping screen you can point a feed
column at, say, the "title" field of a "Text box" paragraph inside your page's
paragraph field. The target IDs follow the pattern
`{host_field} {para_bundle} {para_field}`.

It depends on **Feeds**, **Paragraphs** and **Entity Reference Revisions**. There
is no settings page and no admin dashboard — the module simply adds the paragraph
targets to the Feeds mapping UI, so all of the setup happens on your feed type.

A security note worth keeping in mind: this module processes **external feed data**
into paragraph content, and it has no access‑control role of its own. Validate the
source of any feed you import, and apply **safe text formats** to imported markup —
imported HTML should never land in a permissive text format where it could carry
unfiltered scripts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Feeds /
   Paragraphs dependencies and enable it.

There is **no configuration page** for this module. You configure the paragraph
targets on a **Feeds feed type's mapping**, described below.

## Where it lives in the admin menu

Paragraph Feeds Target adds no admin page of its own. Its targets appear inside the
**Feeds** UI at **Structure → Feed types** (`/admin/structure/feeds`) when you edit
a feed type's **Mapping**.

## How to use it

1. Install and enable this module together with Feeds, Paragraphs and Entity
   Reference Revisions (see [Installation](installation/index.md)), then rebuild the
   cache.
2. Make sure the entity you import into (for example a content type) has a
   **paragraph reference field** whose allowed bundles include the paragraph types
   you want to fill.
3. Create or edit a **Feeds feed type** that targets that entity, and open its
   **Mapping** tab.
4. For each feed source column, choose a paragraph target of the form
   *{your paragraph field} → {paragraph bundle} → {sub‑field}* and map it. Feeds
   will create the paragraphs and populate those sub‑fields on import.
5. When mapping any field that carries markup, choose a **safe text format** for the
   imported value.
