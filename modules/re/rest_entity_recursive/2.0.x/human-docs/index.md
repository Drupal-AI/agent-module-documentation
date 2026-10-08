# REST Entity Recursive — manual setup guide

**REST Entity Recursive** (`rest_entity_recursive`) adds a new REST format,
`json_recursive`, that serialises an entity together with everything it references —
to a configurable depth — in a single response. Drupal's default REST serialisation
gives you an entity and its references as bare target ids, which you then have to
fetch one by one. For a page built from nested paragraphs with media inside them
that becomes a request waterfall: fetch the node, discover the paragraphs, fetch
them, discover their media, fetch that. A recursive format inlines the whole tree so
a decoupled front end gets everything it needs in one call.

You use it by adding the format to a request:

```
GET https://example.com/node/1?_format=json_recursive
```

and you can cap how far it follows references with a `max_depth` argument:

```
GET https://example.com/node/1?_format=json_recursive&max_depth=3
```

Two design points are worth understanding before you build against it. First, the
depth limit is a **correctness control, not just a performance knob** — a cyclic
reference with no limit is an infinite response, so always set a sensible
`max_depth`. Second, **access is applied per entity as the tree is walked**, so a
recursive response can legitimately contain some referenced entities and omit others
the current user cannot view; a consumer that assumes it always receives a complete
tree will misbehave when part of it is filtered out. Two submodules,
`rest_media_recursive` (Media with image styles) and `rest_paragraphs_recursive`
(Paragraphs and Paragraphs Library items), show how to fine-tune the output for
those entity types.

> **Important compatibility warning.** This release (2.0.6-rc8) was found to **fatal
> on class load under Drupal 11.4**, and this was verified against a live site. The
> module's `ReferenceItemNormalizer::normalize()` widens the return type declared by
> core's `EntityReferenceFieldItemNormalizer::normalize(): array`, which PHP forbids
> (return types may be narrowed by a subclass but never widened), so the class cannot
> be loaded at all. When it triggered, the fatal appeared in a live response and took
> Drush down with it; recovery required removing the module from `core.extension`
> directly. **Check this module against your exact core version before enabling it on
> Drupal 11.4+**, and be ready to disable it via configuration rather than the UI if
> it fatals. It commonly arrives on a site as a dependency of `anu_lms`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and the compatibility check to make first.

There is **no configuration page** for this module — the behaviour is controlled
per request through the `_format=json_recursive` and `max_depth` query arguments
described above, and through your normal REST resource/permission setup.

## Where it lives in the admin menu

REST Entity Recursive adds no admin page and no settings form. It registers a
serialisation format that becomes available to your REST resources; you invoke it by
requesting `?_format=json_recursive` on an entity your REST configuration already
exposes.
