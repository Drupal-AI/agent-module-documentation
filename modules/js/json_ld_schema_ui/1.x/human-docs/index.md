# JSON-LD Schema UI — manual setup guide

**JSON-LD Schema UI** (`json_ld_schema_ui`) lets you configure schema.org
structured data (JSON‑LD) for your content entirely through the admin UI — no
custom code required. Search engines read JSON‑LD to power rich results, so this
is a practical way to describe your Articles, Events, Products, Movies, and other
content in a way Google and friends understand.

It works in two layers. First, at the **bundle** level, it adds a schema
configuration tab to bundle settings forms (for example on a content type or a
block type). There you pick one or more schema types for that bundle, choose which
properties to enable, and set default values — with token support so defaults can
pull in entity‑specific values. Schema properties that reference other schema
types can be expanded and configured too, so (for example) a Movie's `actor`
property can carry the referenced Person's name or birth date.

Second, at the **entity** level, each configured bundle gets a field that holds the
per‑entity schema values. Its widget lets an editor pick one of the configured
schema types and fill in the enabled properties (pre‑filled with your defaults). A
computed property produces the token‑replaced JSON‑LD snippet, and a formatter adds
it to the page head when the entity is rendered — independent of how the entity is
themed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Entity API dependency, and enable it.
2. [Configuration](configuration/index.md) — configuring schema per bundle and the
   global settings.

## Where it lives in the admin menu

- **Per‑bundle schema:** a schema configuration (vertical) tab on each bundle's
  settings form — for example **Structure → Content types → *(type)* → manage**,
  or a block type at `/admin/structure/block/block-content/manage/basic`.
- **All bundles at once:** **Configuration → Search and metadata → Content Schema
  Settings** (`/admin/config/search/schemaorg/settings`).
