# Linked Entity Reference — manual setup guide

**Linked Entity Reference** (`linked_entity_reference`) provides a field type that
combines an **entity reference** with a **link**: you reference an entity *and*
attach an arbitrary URL to that reference, all in one field item. The URL is
always optional.

The motivation is a common limitation. Normally a referenced entity links to its
own canonical page (or, for media, to the file). But often you want to reference,
say, a term or a node and send the reader somewhere *else* — an external
resource, a different internal page. You could add a separate link field and wire
it up with custom theming, but then the link belongs to the entity, so you can't
point the same entity at different URLs in different places. Linked Entity
Reference puts the URL on the **field item** instead, so the same entity can carry
a different link every time it's referenced.

Typical uses: a fixed collection of real-estate features each linking to a
photo; skills on a CV each linking to an external resource; media items linked to
any page; reusable teasers with their own destinations. It depends only on core's
**Link** module, and it ships a `linked_entity_reference_slick` submodule for
displaying the references in a Slick carousel.

It offers two form widgets — **Autocomplete** (for referencing any entity type)
and **Media library** (when referencing media) — and two display formatters,
**Label** and **Rendered entity**, which behave like their normal entity-reference
equivalents. As with any authored URL, the reference respects entity access and
the URL is rendered through Drupal's normal escaping.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and
   add the field.

There is **no settings form** for this module. All setup happens on the field you
add and on its form/display configuration, described below.

## Where it lives in the admin menu

Linked Entity Reference adds no admin page. You use it from **Structure →
*(entity type)* → Manage fields** (add the field), **Manage form display** (pick
a widget), and **Manage display** (pick a formatter).

## How to use it

1. Add a field of type **Linked entity reference** to a fieldable bundle — a
   content type, block type, paragraph, etc. Set which entity type/bundles it may
   reference, as with a normal entity reference field.
2. On **Manage form display**, choose a widget:
   - **Autocomplete** — works for referencing all entity types.
   - **Media library** — for referencing media entities.
3. When editing content, pick the entity to reference and, optionally, enter the
   URL to associate with it.
4. On **Manage display**, choose a formatter — **Label** or **Rendered
   entity** — which render like their standard entity-reference counterparts.
5. To show the references in a carousel, enable the **Linked Entity Reference
   Slick** submodule (`linked_entity_reference_slick`) and configure the display
   accordingly.

> **Compatibility note:** there is a known bug that can affect Slick Carousel on
> Drupal 11 — see the project's issue
> [#3467129](https://www.drupal.org/project/linked_entity_reference/issues/3467129)
> if you run into carousel display problems.
