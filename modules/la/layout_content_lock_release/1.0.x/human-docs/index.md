# Layout Content Lock Release — manual setup guide

**Layout Content Lock Release** (`layout_content_lock_release`) is a small workflow
helper for sites that use both the **Content Lock** module and core **Layout
Builder**. With Content Lock in place, an entity gets locked to the editor working on
it — and after saving Layout Builder changes, editors often forget to click *Unlock*,
or are simply left sitting on the edit screen with the lock still held. This module
removes that friction.

When a user saves their Layout Builder changes, it **automatically releases the
Content Lock** they held on that entity, and **redirects them to the View page** of
the node they just edited. So the entity isn't left locked after a successful save,
and the editor lands where they'd expect — no manual *Unlock* click and confirmation
needed.

It's purely an editorial‑workflow convenience. It only releases the *current
editor's own* lock after *their own* successful save; it does not change who is
allowed to edit what — Content Lock still governs that, and this module has no
access‑control role of its own. It depends on core **Node**, core **Layout Builder**,
and the contributed **Content Lock** module, and targets Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Content Lock and Layout Builder.

There is **no configuration page** for this module — it works automatically once
enabled. Its behaviour is described below.

## How it behaves

There is nothing to set up beyond enabling it alongside Content Lock and Layout
Builder. From then on:

1. An editor opens a node for editing and works on its layout in **Layout Builder**
   (Content Lock holds a lock on the node while they do).
2. When they **save** their Layout Builder changes, the module releases their content
   lock on that node automatically.
3. They are redirected to the node's **View** page — no need to find and click
   *Unlock* and confirm.
