# Cloner — manual setup guide

**Cloner** (`cloner`) is a developer‑focused system for duplicating Drupal
entities. Where the popular *Entity Clone* module tries to clone any entity out
of the box with zero configuration, Cloner takes the opposite approach: it gives
you a powerful, plugin‑driven framework and lets *you* decide exactly how each
entity type is copied. Nothing is cloned automatically until you write a small
plugin describing the behaviour you want.

That trade‑off is deliberate. Simple sites are usually happier with Entity Clone.
Cloner shines when your entities are genuinely complex — think Drupal Commerce
products with variations that must be cloned alongside the parent — and you need
full, code‑level control over what gets copied, how references are handled, and
when the new entity is saved. Cloner takes care of handing you the original and
the cloned entity and of persisting them; you just move the data across as your
project requires. You can define as many clone plugins as you like, even several
for the same entity type and bundle, and you can invoke them directly from your
own code anywhere.

Because it is a framework, Cloner has **no settings page and no ready‑made clone
UI**. Clone operations become available on entities only once you create a
matching *ClonerForm* plugin. It requires nothing outside Drupal core, needs PHP
8.1, and provides its own permissions so you can gate who is allowed to clone.
The optional **Cloner Examples** submodule (`cloner_examples`) ships worked
examples you can copy from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) enable the examples submodule.

There is **no configuration page** for this module — it is a developer framework
configured entirely in code. See "How to use it" below for the shape of that
work.

## How to use it

Cloner does nothing on its own. To make entities cloneable you write two kinds of
plugin in a custom module:

- A **Cloner plugin** that describes *how* a given entity type/bundle is cloned —
  which fields carry over, how references are treated, and any per‑project logic.
- A **ClonerForm plugin** that provides the *UI* (an operation link or form) for
  triggering that clone. Cloner and ClonerForm plugins are separate and can be
  mixed and matched.

The quickest way to learn the pattern is to enable the **Cloner Examples**
submodule and read its plugins, or the `docs/` folder shipped with the module.
Cloning creates new content, so it is governed by the user's normal **create
access** for the target entity type *plus* Cloner's own permission — grant that
permission only to the roles that should be allowed to duplicate content.
