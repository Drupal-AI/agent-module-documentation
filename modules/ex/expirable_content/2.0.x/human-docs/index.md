# Expirable Content — manual setup guide

**Expirable Content** (`expirable_content`) lets you give any content entity type a
calculated **expiration date**, so time‑limited content can be retired
automatically instead of lingering past its usefulness. You configure expiration
per bundle, and — importantly — the module is designed to be seamless and invisible
to the target entity type, so it slots in without disrupting how that content
otherwise works.

One deliberate design choice sets it apart from similar tools: Expirable Content
**does not itself take any action** when an expiration (or warning) date arrives.
It calculates and exposes the dates, and leaves the "what happens next" to you.
That's a feature, not a gap — it means you can drive the response with whichever
framework you already use: **Rules**, **ECA**, the **Message** module suite, or a
custom cron routine. Compared to something like Node Auto Expire, which only works
with nodes and assumes an email should be sent, Expirable Content works with any
content entity type and stays neutral about the outcome.

It integrates with **Views**, so you can build listings around expiration (for
example, "content expiring this week" or "already expired"). The module provides
its own permissions to control who can manage expiration settings, and it has no
broader access‑control role. It supports Drupal 10.1+ and 11, and the current
release is a release candidate (2.0.0‑rc1), so test before relying on it in
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enable expiration per bundle, set
   permissions, and decide how to act on expiry.

## Where it lives in the admin menu

Expirable Content adds expiration configuration to your content entity **bundles**
(for example, on a content type's settings under **Structure → Content types**),
and its permissions live under **People → Permissions**. See
[Configuration](configuration/index.md) for the walk‑through.
