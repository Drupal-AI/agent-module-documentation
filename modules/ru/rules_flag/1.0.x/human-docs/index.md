# Rules Flag — manual setup guide

**Rules Flag** (`rules_flag`) connects two popular automation modules —
[Rules](https://www.drupal.org/project/rules) and
[Flag](https://www.drupal.org/project/flag) — so that flagging or unflagging an
entity can trigger a Rules reaction. With it, "when a user flags this article, do
X" becomes something you can build in the Rules UI without custom code.

Concretely, it adds:

- **Events** that fire *after* an entity is flagged or unflagged — for example
  *After flagging a content item* or *After flagging a user*. Each event hands your
  rule two pieces of context: the flagging entity and the entity that was flagged.
- **Conditions**, such as *the entity is flagged* and *the flag has id*.
- **Actions**, including *create a new flagging entity* and *delete a scheduled
  entity*.
- **Example rules** that are imported (in a disabled state) when you install the
  module — things like "show a message when the article is flagged" or "flag the
  article when it is created and unflag it on a schedule." They're there as ready
  templates you can enable and adapt.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Flag, Rules, and Job Scheduler dependencies.

There is **no dedicated configuration page** for this module. You build reactions in
the Rules UI, described in "How to use it" below.

## How to use it

1. Make sure you have at least one **Flag** defined (**Structure → Flags**) — the
   events and conditions operate on flags.
2. Go to **Configuration → Workflow → Rules** and either enable one of the imported
   **example rules** or create a new reaction rule.
3. Choose one of the flag events, such as **After flagging a content item**. Inside
   the rule you can use the two context variables it provides — the flagging entity
   and the flagged entity.
4. Add conditions (for example *the flag has id*) and actions (for example *create a
   new flagging entity*, or any standard Rules action such as sending a message or
   an email), then save.

> **Good practice:** review the actions your flag‑triggered rules perform — anything
> that changes access or sends communications — so that flagging can't set off
> unintended privileged behavior.
