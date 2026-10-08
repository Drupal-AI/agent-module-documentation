# Language Hierarchy — manual setup guide

**Language Hierarchy** (`language_hierarchy`) lets you configure parent/child
inheritance between the languages on a multilingual site. When a translation is
missing in one language, Drupal normally jumps straight to the site default
language (often English). With Language Hierarchy you tell it to fall back through
a chain of *related* languages first — so, for example, Austrian German
(`de-at`) falls back to German (`de`) before it ever reaches English, and a
country variant like `en-GB` or `es-MX` falls back to its base language `en`/`es`.

The clever part is that this fallback works across four different subsystems at
once: **content** translations, **configuration** translations (Views labels,
field labels, menus), **interface** (locale) string translations, and **path
aliases**. Set the hierarchy once and all four respect it. It means you can keep a
base language fully translated and let regional variants override only the strings
that actually differ, instead of duplicating every translation.

You configure it entirely through Drupal's own **language** admin forms — the
module adds a "Translation fallback language" select to each language's edit form,
and turns the languages overview into a drag-and-drop parent/child tree. There is
no settings page of its own and no permission of its own; the parent of each
language is stored as a third-party setting on that language's configuration, so
it deploys cleanly as exported config. It depends on core's **Language** module,
and integrates with core **Locale** and **Configuration Translation** when those
are enabled. It also adds a Views sort and a Views filter for showing the single
most-relevant translation of each item.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set each language's fallback parent
   through the core language forms, and the Views handlers it adds.

## Where it lives in the admin menu

There is no dedicated settings page. You configure everything under
**Configuration → Regional and language → Languages**
(`/admin/config/regional/language`) — either on the overview (as a parent/child
tree) or on each language's own edit form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a language at **Configuration → Regional and language → Languages** and set
   its **Translation fallback language** to the parent it should inherit from (e.g.
   set German as the fallback for Austrian German). Or arrange the whole hierarchy
   at once by dragging languages under one another on the overview form.
3. That's it — content, config, interface, and path-alias lookups now walk the
   chain automatically. To confirm the resolved order for a language, run:

   ```bash
   drush php:eval 'print implode(",", array_keys(\Drupal::languageManager()->getFallbackCandidates(["langcode" => "de-at"])));'
   ```

   For a `de-at → de` chain this prints something like `de-at,de,en,und`.

See [Configuration](configuration/index.md) for the details, including the two
Views handlers ("Content language relevance" sort and "Most relevant translation"
filter) for collapsing a listing to each item's best translation.
