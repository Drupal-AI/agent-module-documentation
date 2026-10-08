# Configuration

Simple Sitemap DiWoo doesn't work purely on-enable — you set it up by adding a
metadata field, defining a sitemap type that uses the DiWoo generators, and
creating a variant. Here is the sequence.

## 1. Add the DiWoo metadata field

The module provides a custom field type, **`diwoo_meta`**, for holding DiWoo
metadata. Add this field to each media entity type whose files you want to publish
in the DiWoo sitemap (via the media type's **Manage fields**).

## 2. Point the module at your file-reference field

In the module's settings, tell it which file-reference field on your media entities
holds the actual file to index. This is how the sitemap knows which file URL to
emit for each media item.

## 3. Create a DiWoo sitemap type

Go to **`/admin/config/search/simplesitemap/types`** (Configuration → Search and
metadata → Simple XML Sitemap → the sitemap *types* screen) and create a new
sitemap type with:

- **Sitemap Generator:** DiWoo Sitemap Generator
- **URL Generator:** DiWoo Media URL Generator

These two generators are what this module contributes to Simple XML Sitemap.

## 4. Create a sitemap variant

Create a sitemap **variant** linked to the new DiWoo sitemap type. The variant is
the actual sitemap that gets generated and served.

## 5. Optional — default values and token behaviour

Finally, you can tune default metadata values and how token replacement behaves on
the module's own settings page at
**`/admin/config/search/simplesitemap/diwoo-settings`**. Setting sensible defaults
here means you don't have to fill in every metadata value on every media item by
hand — the defaults (and any tokens) fill them in.

## A note on what gets published

This sitemap advertises media **file** URLs to indexers and harvesters. That is the
whole point for DiWoo compliance, but it does mean any file you include becomes
publicly discoverable — so only publish media that is genuinely intended to be
open-government material.
