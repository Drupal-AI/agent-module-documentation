# Canvas Entity Reference — manual setup guide

**Canvas Entity Reference** (`canvas_entity_reference`) adds entity-reference
support to the **Drupal Canvas** page builder. Out of the box, Canvas components
take simple prop values (text, numbers, and so on). This module lets a component
prop instead point at a real Drupal entity — a taxonomy term, node, user, or media
item — so what an author picks in the Canvas editor is genuine structured content
rather than a hand-typed string. It has built-in definitions for taxonomy terms,
nodes, users, and media, and can support any entity type via an `x-entity-type`
annotation in a component's YAML.

The way it works is declarative: a developer adds `x-entity-type: taxonomy_term`
(or `node`, `user`, `media`) to a component prop, and that prop automatically
becomes an entity-reference autocomplete field in the editor — no custom field
configuration or custom PHP required. It supports single and multi-value
references (comma-separated tags), per-prop bundle filtering, per-prop widget
overrides (for example Tagify or Entity Browser), optional auto-creation of new
taxonomy terms, and an `entity_render()` Twig function so a component template can
render a referenced entity in any view mode. It ships seven example components so
you can see each pattern in practice.

One thing worth knowing up front: a reference never bypasses access. A referenced
entity that the current user cannot view simply will not render, so the module
respects your existing content-access rules inside Canvas.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Drupal Canvas.
2. [Configuration](configuration/index.md) — the optional global settings for
   allowed vocabularies, term auto-creation, and the default widget.

## Where it lives in the admin menu

The module works as soon as a developer adds an `x-entity-type` annotation to a
component prop — there is nothing you *must* configure. An optional global
settings form sits at **Configuration → Content authoring → Canvas Entity
Reference** (`/admin/config/content/canvas-entity-reference`), where you can
restrict which taxonomy vocabularies are offered, toggle automatic term creation,
and choose the default widget. See [Configuration](configuration/index.md) for the
details, and remember these can also be overridden per-prop in the component YAML.
