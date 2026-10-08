# Taxonomy Max Depth — manual setup guide

**Taxonomy Max Depth** (`taxonomy_max_depth`) lets you cap how deep a taxonomy
vocabulary's term hierarchy is allowed to go, set separately for each vocabulary
and enforced when editors add or move terms. It is a simple way to keep your
category trees from growing arbitrarily deep — for example, "Tags should stay
flat," or "Categories may be at most three levels."

It works by adding a **Maximum ancestor depth** setting to each vocabulary's edit
form. The limit is stored as a *third‑party setting* on the vocabulary, so it
travels with your configuration export and deploys consistently across
environments. When an editor saves a term, a validator checks the depth its
parents would give it — and, for an existing term, re‑checks its children so that
moving a whole subtree can't quietly push descendants past the cap. If the limit
would be exceeded, the save is blocked with a form error and clear feedback.

Choosing **0 (no hierarchy)** forbids parents entirely, turning the vocabulary
flat; leaving the value **Unlimited** removes the restriction. The term overview
(drag‑and‑drop) screen respects the same limit.

> **Important:** enforcement is at the **form layer** only. Terms created
> programmatically through the entity API (`$term->save()`) are *not*
> automatically validated against the limit — if you create terms in code, check
> the depth yourself (the module ships services to help).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the settings reader/writer
services and the tree‑depth helper — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set a vocabulary's maximum depth and
   understand how the limit is enforced.

## Where it lives in the admin menu

There is no dedicated settings page. You set the limit per vocabulary at
**Structure → Taxonomy → *your vocabulary* → Edit**
(`/admin/structure/taxonomy/manage/*`), using the **Maximum ancestor depth**
field.

## How to use it

1. Install and enable the module.
2. Edit a vocabulary and set its **Maximum ancestor depth**.
3. Save. From then on, editors adding or reordering terms in that vocabulary are
   held to the limit.
