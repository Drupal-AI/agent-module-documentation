# Random Entity Reference Formatter — manual setup guide

**Random Entity Reference Formatter** (`random_reference_formatter`) provides a
field formatter that renders a **random subset** of the entities referenced by an
entity-reference field. Instead of showing every referenced item (or a fixed
first few), it picks a configurable number of them at random each time — perfect
for "random featured items", rotating spotlights, or varied related content.

The clever part is *how* it randomizes: the random selection is loaded via
**AJAX**. That means the surrounding page can still be cached normally (including
for anonymous users) while the randomized block refreshes per request — you get
rotation without sacrificing page-cache performance.

It's a display-only feature and plays nicely with access control: referenced
entities are rendered respecting their own access, so only items a visitor is
allowed to see can appear. It works with any content entity type reached through
an `entity_reference` or `entity_reference_revisions` field — nodes, taxonomy
terms, Paragraphs, and so on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You set it up entirely on a
reference field's *Manage display*, as described below.

## How to use it

1. Make sure you have an entity-reference field (an `entity_reference` or
   `entity_reference_revisions` field) that references several entities — this is
   what will be randomized.
2. Go to that entity's **Manage display** screen (for example **Structure →
   Content types → *(your type)* → Manage display**).
3. For the reference field, choose the **Random Rendered entity** formatter.
4. In the formatter settings, set **how many** random items to display and the
   view mode used to render each one.
5. Save. On each page load, the field will fetch and render that many randomly
   chosen referenced entities via AJAX.
