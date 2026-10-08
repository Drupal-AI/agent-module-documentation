# Entity Form Monitor — manual setup guide

**Entity Form Monitor** (`entity_form_monitor`) helps prevent lost edits by warning
someone that the content they're editing has been changed by another user since
their form was opened. While an edit form is open, a small JavaScript poller
periodically asks the server for the entity's current *changed* timestamp; if it
differs from the timestamp captured when the form loaded, the editor gets a warning
dialog before they submit stale data.

The problem it solves is the classic two-editors collision: two people open the
same node, one saves, and the other unknowingly overwrites those changes on submit.
This module gives the second person a heads-up first. It's a lighter touch than
fully locking content (the way Content Lock does) and a simpler alternative to
merge-based approaches (like the Conflict module) — it just tells you your form is
out of date. It also works with entities embedded through the Inline Entity Form
module.

It needs a little configuration to target the right content, but it's usable
immediately: by default it can monitor all eligible content entities. Only content
entities that implement `EntityChangedInterface` and already exist (not brand-new,
unsaved ones) get the monitor attached. It supports Drupal 9 and 10 and has no
module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which content to monitor and
   how often to poll.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Entity Form Monitor**
(`/admin/config/content/entity-form-monitor`).
