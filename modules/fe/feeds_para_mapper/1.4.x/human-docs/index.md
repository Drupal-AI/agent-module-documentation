# Feeds Paragraphs — manual setup guide

**Feeds Paragraphs** (`feeds_para_mapper`) extends the Feeds importer so you can
map incoming source values **into fields that live inside Paragraphs** — including
nested and multi‑valued paragraph structures — instead of only into fields
directly on the imported entity. If your content is modeled as repeating
paragraph "sections", "cards", "slides", or FAQ items, this lets you populate that
structure straight from a CSV, RSS, XML, or JSON feed.

It has **no configuration page, permissions, Drush commands, or settings of its
own** — it works entirely through the Feeds mapping UI. When a Feed Type's
processor creates an entity that has a Paragraphs field (technically an
`entity_reference_revisions` field), Feeds Paragraphs walks the referenced
paragraph bundles and exposes each supported **leaf field** as its own Feeds
mapping target, labelled with its host path (for example `Body (field_sections)`
or, for a nested paragraph, `Title (field_sections:field_cards)`). The raw
`paragraphs` target that core Feeds would otherwise offer is removed automatically,
so you map to the individual sub‑fields instead.

At import time it creates, duplicates, updates, or "slices" the Paragraphs
entities as needed to hold your values, and it handles re‑imports gracefully:
changed paragraphs get new revisions and paragraphs that are no longer needed are
pruned from the host field. A per‑mapping **Maximum Values** setting (shown when
both the paragraph field and the target field are multi‑valued) controls how many
values one paragraph holds before a new one is spun up for the overflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with Feeds and
   Paragraphs) via Composer and enable it.

## Where it lives in the admin menu

There is **no page of its own**. All the action is on a Feed Type's **Mapping**
tab at **Structure → Feeds → *(your feed type)* → Mapping**
(`/admin/structure/feeds/manage/<feed_type>/mapping`), where the paragraph
sub‑field targets appear.

## How to use it

### What you need first

- Feeds and Paragraphs enabled (see [Installation](installation/index.md)).
- A **Feed Type** whose processor creates an entity (for example a Node) whose
  bundle has a **Paragraphs field** pointing at one or more paragraph bundles.
- Those paragraph bundles must contain fields whose type has a Feeds target plugin
  (text, long text, link, email, number, date, boolean, file/image, and so on). A
  sub‑field whose type has no Feeds target is simply skipped.

### Mapping into paragraphs

1. Go to **Structure → Feeds → *(your feed type)* → Mapping**.
2. Under **Add a target**, you'll now see — instead of one opaque *Paragraphs*
   target — **one target per supported leaf field** inside the referenced paragraph
   bundles, each labelled with its host path (e.g. `Body (field_sections)` or
   `Title (field_sections:field_cards)` for a nested paragraph).
3. The first time the module strips the old raw `paragraphs` target, you may see a
   warning: *"Mapping has been updated, please refresh the page."* Just reload the
   mapping form once.
4. Map each source column to the paragraph leaf target you want, exactly as you
   would any other Feeds mapping. Columns that belong to the same paragraph
   co‑populate the same paragraph entity.

### The Maximum Values setting

Some paragraph targets show an extra **Maximum Values** field in their mapping
settings. It appears only when both the host Paragraphs field and the target
sub‑field are multi‑valued. It means: when the incoming values exceed this number,
a **new paragraph** is created to hold the remaining values. Leave it unlimited to
put everything into a single paragraph.

### Splitting one column into several values

Feeds Paragraphs maps the values it is handed — it does not itself split a
delimited string. To turn a single cell like `a,b,c` into several paragraph
values, add a **Feeds Tamper** "Explode" transform to that source before it reaches
the mapping (see the [Installation](installation/index.md) note about Feeds
Tamper).

### On re-import

Running the import again updates existing content rather than duplicating it:
unchanged paragraphs are left alone, changed ones are updated (creating a new
revision), overflow creates new paragraphs, and paragraphs that are no longer
referenced are removed from the host field. Revision history is preserved.
