# Paragraphs Sets Plugins — manual setup guide

**Paragraphs Sets Plugins** (`paragraphs_sets_plugins`) is a developer/site-builder
extension for the **Paragraphs Sets** module. A Paragraphs Set is a predefined
bundle of paragraphs an editor can drop in as a starting point; normally the set's
source data just pre-fills static values. This module adds a **data-transform
plugin system** so that, when a set is applied, its source data is first run
through "process" plugins that can do more than static prefilling — creating
entities, building nested entity structures, or mapping values — before the
resulting paragraphs are inserted.

The plugins behave a bit like migration process plugins. The module ships three:
**Simple** (a straight identity/value mapping), **CreateEntity** (constructs
related entities for an entity-reference field as part of applying the set), and
**NestedEntities** (populates multi-level entity/paragraph trees). A set
definition can, for example, tell a field to use the `create_entity` plugin so the
referenced entities are created and pre-populated automatically instead of being
left empty.

This is an extension point for developers rather than an end-user feature: it
defines a `@ParagraphsSetsProcess` plugin type (with a base class and plugin
manager) and wraps Paragraphs Sets' `data_alter` hook to walk each set's data
recursively and let plugins transform it in place. It adds **no admin UI and no
permissions**. Developers extend it by writing their own `@ParagraphsSetsProcess`
plugin. It depends on the **Paragraphs Sets** module and supports Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside
   Paragraphs Sets) and enable the module.

There is **no configuration page** for this module. It has no admin UI — you use
it by referencing its process plugins in your Paragraphs Set definitions and, for
custom logic, by writing your own plugin, as described below.

## How to use it

1. Make sure the **Paragraphs Sets** module is installed and you have one or more
   Paragraphs Sets defined, then enable this module (see
   [Installation](installation/index.md)).
2. In a Paragraphs Set definition, have a field use one of the process plugins —
   for example `simple` for a straight value mapping, `create_entity` to construct
   nested entities for an entity-reference field, or `nested_entities` for a
   multi-level tree. When the set is applied, the data runs through the plugin and
   the paragraphs (and any related entities) are built accordingly.
3. To add your own transform logic, write a `@ParagraphsSetsProcess` plugin
   (extending the module's `ProcessPluginBase` / `ProcessPluginInterface`) in a
   custom module. It is discovered automatically and can be referenced from set
   definitions just like the built-ins.
