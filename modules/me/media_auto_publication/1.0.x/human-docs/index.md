# Media auto publication — manual setup guide

**Media auto publication** (`media_auto_publication`) solves a common editorial annoyance:
when editors upload media into an **unpublished** node, the media entities themselves often
stay unpublished. After the node goes live, its images or videos can then appear broken or
"access denied" to anonymous visitors, because the media is still unpublished even though
the content isn't. This module fixes that automatically — the moment a host entity
transitions **to published**, any unpublished media it references is published alongside it.

It works across content types: it scans the saved entity's fields for entity‑reference
fields that point at media, and publishes any referenced media that is still unpublished. It
applies to nodes and, in principle, any publishable fieldable entity, and it only acts on
the transition to published (a brand‑new published entity, or one whose previous revision
was unpublished), so it does no redundant work on already‑published media.

**One behavior to be aware of:** the publish is **unconditional** on that transition. When a
host entity is published, the module publishes the media it references without consulting
content moderation. This is the intended design, but it means media
you deliberately kept unpublished (for example a draft in a moderation workflow) will be
published if it is referenced by a host entity that goes live. Keep that in mind on sites
with content moderation on media.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** and no settings — installing the module enables the
behavior for all fieldable publishable entities.

## Where it lives in the admin menu

Media auto publication adds no admin page, no permissions, and no settings form. It works
entirely in the background whenever content is saved.

## How to use it

There is nothing to configure. Once enabled:

1. An editor uploads media into an unpublished node (the media entities may be unpublished
   too).
2. When that node is **published**, the module automatically publishes any unpublished media
   it references.
3. The media now renders correctly for anonymous visitors — no manual publishing of each
   media item required.
