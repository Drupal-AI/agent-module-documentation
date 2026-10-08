# Search API Exclude Entity — manual setup guide

**Search API Exclude Entity** (`search_api_exclude_entity`) adds a simple "exclude
from search" checkbox to individual pieces of content, so an editor can keep one
node (or user, term, media item, etc.) out of a Search API index without
unpublishing it. A "thank you" page or an internal landing page can stay publicly
reachable while never showing up in site search.

It works by providing a custom **boolean field** — with its own widget and
formatter — that you attach to any fieldable entity type or bundle. When an editor
ticks the checkbox on an entity, a Search API processor removes that item from the
index during indexing, so it never reaches the search backend. Because it's a real
field, its label, description, and position are configurable per bundle, and it
works with Views out of the box. You can even add several exclude fields on one
bundle — one per index — and tell each index's processor which field(s) to honor,
so an entity can be excluded from one index while still indexed in another.

Enabling the module does not exclude anything on its own: you attach the field to a
bundle and enable the processor on your index (see "How to use it" below). It
depends on core's **Field** module and the **Search API** module. Two optional
submodules broaden the idea: **Search API Exclude Entity By Field** excludes items
when any indexed field matches a configured value (no dedicated field needed), and
**Search API Exclude Entity - Metatag** excludes published entities whose Metatag
`robots` value contains `noindex`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick which submodules you need.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it in two familiar places: the
**Field UI** (Structure → your content type → Manage fields) to add the exclude
field, and the **Processors** tab of your Search API index
(Configuration → Search and metadata → Search API) to turn on the exclusion and
choose which fields it honors.

## How to use it

Setup is two steps.

**1. Add the exclude field to a bundle.** Go to **Structure → Content types → (your
type) → Manage fields → Add field** and choose the field type **Search API Exclude
Entity**. It's a single-value boolean (the cardinality is fixed to one). On the
widget settings you can set:

- **Checkbox label** — the text shown next to the checkbox (defaults to *"Yes,
  exclude this entity from the search indexes."*).
- **Use details container** — when on (the default), the checkbox is rendered inside
  a collapsible *details* element in the node form's "advanced" sidebar; when off,
  it's a plain container.

The provided formatter displays the value as a simple Yes/No if you show it on the
entity display.

**2. Enable the processor on your index.** Open your Search API index, go to the
**Processors** tab, and enable **Search API Exclude Entity**. In its settings, each
entity type in the index shows a list of the available exclude fields — tick the
one(s) that should control exclusion. From then on, any entity whose chosen exclude
field is ticked is dropped from that index at indexing time.

### Permission

The module defines one permission, **Edit search api exclude entity** (`edit search
api exclude entity`), which controls who may toggle the exclude checkbox on an
entity. Grant it (at **People → Permissions**) to the roles that should be able to
flag content for exclusion.
