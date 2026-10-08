# Auto Entityqueue — manual setup guide

**Auto Entityqueue** (`auto_entityqueue`) automatically adds newly created
entities to an [Entityqueue](https://www.drupal.org/project/entityqueue)
subqueue — no manual "add to queue" step. When a new entity is created and its
type and bundle match a queue you have marked for auto-add, the module drops it
straight into every subqueue of that queue.

This keeps self-maintaining lists populated as editors work: a "Latest articles"
queue, a homepage carousel, a "New arrivals" product list, or an editorial
"needs review" queue. You choose whether new items go to the **back** of the
queue (the default, for chronological order) or the **front** (so the newest
appears first). If the queue has a maximum size, the module windows it — pushing
a new item at one end pops the oldest item off the other end, giving you a
rolling "top 10 recent" effect.

Setup is minimal because there is no page of its own: it adds a small **Auto
Entityqueue** section with two checkboxes to the *edit form of each Entityqueue*.
It only acts on entity **creation** (not later edits), only on **enabled**
queues, and only for the bundles the queue targets. It requires the Entityqueue
module and defines no permissions or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Entityqueue dependency and
   installing with Composer.
2. [Configuration](configuration/index.md) — the two checkboxes on an
   Entityqueue, and how insert order and max size behave.

## Where it lives in the admin menu

There is no dedicated settings page. The two auto-add options appear on each
queue's edit form at **Structure → Entityqueues → (queue) → Edit**, in a section
labelled **Auto Entityqueue**.
