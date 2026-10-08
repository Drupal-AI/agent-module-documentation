# Entity Usage Validate — manual setup guide

**Entity Usage Validate** (`entity_usage_validate`) is a small editorial safety
net. When an author saves a **published** node that references **unpublished
media**, the module shows a warning message naming each media item that still
needs to be published. It catches the common go-live trap where an article goes
public but an image or video it embeds is still unpublished — so the media
silently fails to render for visitors.

The warning is **advisory only**. The module never blocks the save, never changes
the node, and never exposes anything to anonymous users. It simply reminds the
editor (who already has edit access to that node) that something referenced is
not yet live, listing each unpublished item by title and ID so the fix is
obvious.

Under the hood it reads relationships through the
[Entity Usage](https://www.drupal.org/project/entity_usage) API rather than
querying entities directly, and it deliberately runs *after* Entity Usage has
recorded the current revision's relationships, so the check always reflects the
latest content. It works on any content type that references media, requires the
Entity Usage module, and has **no configuration of its own** — it works the
moment you enable it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Entity Usage dependency.

There is **no configuration page** for this module — it integrates transparently
and requires no settings.

## How to use it

There is nothing to switch on beyond enabling the module. Once it is active,
simply save a published node that embeds media. If any referenced media item is
unpublished, a warning message appears at the top of the page listing the
offending items by title and ID. Publish that media and the warning goes away.
The check is skipped entirely for unpublished nodes and for nodes that reference
no media.
