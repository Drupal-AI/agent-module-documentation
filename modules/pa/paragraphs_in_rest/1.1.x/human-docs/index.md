# Paragraphs in REST — manual setup guide

**Paragraphs in REST** (`paragraphs_in_rest`) makes Paragraphs usable over
Drupal's core REST API. Normally, when a REST resource serializes an entity, its
Paragraphs field (an entity-reference-revisions field) comes back as bare
*references* rather than the actual paragraph content — forcing a decoupled client
to make extra requests to "expand" each paragraph. This module registers a custom
**normalizer** that serializes those nested paragraphs **inline**, recursively,
to any depth. The result: a single REST request to a node can return all of its
paragraph content — including paragraphs nested inside other paragraphs — as
nested data.

It works with the **JSON** and **XML** formats provided by the core RESTful Web
Services (`rest`) module. Note that it is **not** designed for JSON:API — if
you're using JSON:API, this module isn't the right tool.

There is nothing to configure in a settings screen; the normalizer applies
automatically once the module is enabled and you have a REST resource set up. What
you do need to think about is **access**. The REST resource still enforces the
parent entity's access, and paragraphs conventionally inherit their parent's
access rather than being independently access-controlled — so inline serialization
exposes the same data the parent already exposes. The one thing to review is
**field-level access and which fields the resource exposes**, so that a paragraph
field you consider private isn't quietly serialized out to clients. It depends on
core **REST** and the **Paragraphs** module and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set up a core REST resource.

This module has **no configuration form of its own**. All configuration happens on
the **core REST resource** (which formats/methods are enabled, and which fields
are exposed). Once that resource is configured and this module is enabled, inline
paragraph serialization is automatic.

## How to use it

1. Enable the core **RESTful Web Services** (`rest`) module and the **Paragraphs**
   module.
2. Enable Paragraphs in REST (see [Installation](installation/index.md)).
3. Configure a core REST resource for the entity you want to expose (for example
   the Content/node resource), choosing the JSON or XML format and the HTTP
   methods you need. This is standard core REST setup — Paragraphs in REST does
   not add its own screen.
4. Request the entity over REST. Its Paragraphs fields now come back as nested,
   inline data instead of references, all the way down through nested paragraphs.
5. **Review access before going live:** confirm that every field exposed by the
   resource — including fields on your paragraph types — is safe to hand to the
   clients that can reach the resource. Paragraphs inherit the parent's access, so
   check field-level access for anything you intend to keep private.
