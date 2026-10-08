# Entity Autocomplete Suggestions — manual setup guide

**Entity Autocomplete Suggestions** (`entity_autocomplete_suggestions`) enriches the
labels shown in Drupal's entity-reference autocomplete so editors can pick the right
item at a glance. Instead of a bare title, each suggestion can show the **entity
type** (for example the content type or vocabulary name) and a **Published /
Unpublished** status marker, and you can **cap** how many suggestions appear. A
typical enriched suggestion looks like `Basic page1 (12) [basic_page, Published]`.

It works by overriding the core entity autocomplete route's controller with one that
augments each label, using the field's own selection handler to fetch matches — so
the entities offered, and the access checks on them, are exactly what core would
return; only the labels are decorated. Status is only shown when you enable it, and
because the module reuses the selection handler, unpublished items still appear only
to users who were already allowed to see them.

The behaviour is controlled from a single settings form. There you can allow or
disallow showing the entity type, allow or disallow the published/unpublished
status, show the vocabulary name (and, on Drupal 8.8+, its status), and set the
result limit (default **10**). Out of the box the entity type is shown, unpublished
content is hidden, and the limit is 10. The module works on Drupal 9 and 10 and
depends only on core's **System** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose what appears in suggestions and
   set the result limit.

## Where it lives in the admin menu

The settings form is at **Configuration → Entity Autocomplete Suggestions Config**
(`/admin/config/autocomplete-suggestion-configurations`).
