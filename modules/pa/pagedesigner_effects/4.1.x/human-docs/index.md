# Pagedesigner Effects — manual setup guide

**Pagedesigner Effects** (`pagedesigner_effects`) is an add‑on for the
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) drag‑and‑drop page
builder. It lets editors apply **visual effects** — animations, transitions and
similar treatments — to elements they build in Pagedesigner, directly from the
Pagedesigner interface. It's a way to add movement and polish to a built page without
writing CSS or JavaScript.

It is a content‑display / site‑building feature that affects how Pagedesigner elements
are *presented*; it does not change content or access. The module provides its own
permission so you can control who is allowed to apply effects.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Pagedesigner.

This add‑on has **no separate configuration page** (its configure route is empty). You
apply effects from within the Pagedesigner editor, per element. Set up the base
[Pagedesigner](../../../pagedesigner/4.x/human-docs/index.md) module first, and review
its permissions to decide which roles may apply effects.

## How to use it

1. Install and enable both Pagedesigner and this module (see
   [Installation](installation/index.md)).
2. Edit content that uses Pagedesigner and select an element.
3. Use the effects options this module adds to apply an animation or transition to that
   element.
4. Save the page.
