# Search API Boolean Field Boost — manual setup guide

**Search API Boolean Field Boost** (`search_api_boolean_field_boost`) is a small
Search API processor that lets you promote items in search results based on a
**boolean flag**. If a chosen boolean field on an indexed item is TRUE, a boost
factor you configure is applied, lifting that item's relevance in the results.

The classic use case is a "featured" or "extra boost" flag. You add a boolean field —
say *Extra Boost* — to a content type, and configure this processor to apply a boost
when that field is TRUE. Editors can then tick the box on any node to push it higher
in search results, all without writing any custom ranking code. It works equally well
for "editor's pick", "in stock", "promoted", and similar editorial signals.

The module provides a single processor plugin (`boolean_field_boost`) that runs at the
indexing stage. It has no routes, permissions, or services of its own — you configure
it entirely within the Search API index's processor settings, so it is governed by
Search API's own admin permissions. Because the boost is applied at **index time**,
you need to **re-index** after changing the boost settings (or after flipping the flag
on existing content) for the change to take effect. It depends only on the **Search
API** module and targets Drupal 10.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no separate settings page — you enable and configure the processor on the
index itself:

1. Add a **boolean field** (for example *Extra Boost*) to the content type you want
   to promote, and make sure it is one of the fields on your Search API index.
2. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`), open your index, and switch to the
   **Processors** tab.
3. Enable the **Boolean Field Boost** processor.
4. In its settings, pick the boolean field and assign a **boost factor** (an
   "Ignore" option lets you disable a field). Use the standard boost values Search
   API provides.
5. Save, then **re-index** the content so the boosts are applied.

You can combine this processor with other Search API processors to tune overall
relevance.
