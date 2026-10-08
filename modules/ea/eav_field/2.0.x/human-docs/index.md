# EAV Field — manual setup guide

**EAV Field** (`eav_field`) lets a single Drupal field carry an open-ended,
editor-defined set of attributes on an entity — without you adding a separate
Drupal field for every possible property. It implements the classic
**Entity–Attribute–Value** data model: instead of modelling "colour", "weight",
"material", and a hundred other properties as their own fields, you define those
as reusable **attributes** once, then attach one `eav` field to a bundle to hold
them all.

Each attribute declares its own value type — string, long text, integer,
decimal, boolean, entity reference, or a list (options) — along with the widget
used to edit it and the formatter used to display it. Values are stored in a
dedicated `eav_value` entity keyed back to the host, so your content tables stay
lean even when the attribute set is large or varies from item to item. This makes
it a natural fit for catalogues, product specs, or classified-style listings
where the fields differ per item and are maintained by editors rather than
developers.

A neat touch is **category scoping**: an attribute can apply globally, or be tied
to a taxonomy **category**, and EAV will match attributes to a host entity by
comparing the host's entity-reference field against the attribute's category
(parent terms included). So a "Laptops" product can automatically offer laptop
attributes while a "Chairs" product offers furniture ones. EAV Field requires the
**Entity API** (`entity`) module plus core `field`, `text`, and `options`, needs
**PHP 8.3**, and runs on Drupal 10 and 11 (and is declared forward-compatible to
core 15). All admin routes are gated by the `administer eav attributes`
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define attributes and attach the
   EAV field to a bundle.

## Where it lives in the admin menu

You manage attributes under **Structure → EAV → Attributes**
(`/admin/structure/eav/attributes`), gated by the **Administer EAV attributes**
(`administer eav attributes`) permission. You add the actual EAV field to a bundle
through the usual **Manage fields** screen.
