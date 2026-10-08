# Mercury Editor Content Lock — manual setup guide

**Mercury Editor Content Lock** (`mercury_editor_content_lock`) is a small bridge
that brings the [Content Lock](https://www.drupal.org/project/content_lock) module's
edit‑locking into the [Mercury Editor](https://www.drupal.org/project/mercury_editor)
page‑building experience. Content Lock uses *pessimistic* locking — when one person
opens a piece of content for editing, it is locked so a second person cannot edit
the same content at the same time and accidentally clobber the first person's work.
This module makes that locking behave sensibly inside Mercury Editor's UI.

With both Mercury Editor and Content Lock enabled on a content type, editors get a
clear experience: an **unlock** button lets an editor release the lock and discard
their current changes; and when someone tries to edit content that is already
locked, Mercury Editor's interface is disabled and a modal explains why. If that
person has permission to break locks, the modal also offers them an unlock option.

The module is deliberately thin — it provides the UI integration only and has **no
settings of its own**. All the actual locking behaviour is governed by the Content
Lock module. It is a companion module: it needs both **Mercury Editor** and
**Content Lock** present, and works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Mercury Editor and Content Lock.

There is **no configuration page** for this module — it deliberately adds no
settings. Install and configure Mercury Editor and Content Lock as normal, and this
bridge wires the two together automatically.

## How to use it

Set up **Mercury Editor** and **Content Lock** the way you normally would (including
enabling Content Lock for the content types you care about, and granting the
relevant lock/break‑lock permissions). Once this module is enabled, Content Lock's
locking simply applies within Mercury Editor: locked content shows the disabled
interface and explanatory modal, and editors see the **unlock** button where
appropriate.
