# Config Entity Icon — manual setup guide

**Config Entity Icon** (`config_entity_icon`) lets you attach an **icon** to any
configuration entity — content types, taxonomy vocabularies, menus, media types,
even custom config entity types — and stores your choice as a *third-party setting*
on the entity itself. That means no new fields and no schema changes: the icon
simply travels with the entity's configuration when you export and deploy it.

It's built on Drupal core's **Icon API** (available in 11.1+) by way of the
contributed **UI Icons** module, so any icon pack you've installed works out of the
box — Lucide, Bootstrap Icons, Font Awesome, Iconify, or your own custom SVG packs.
The point is to replace the old patchwork of per-entity-type icon modules
(`node_type_icon`, `taxonomy_term_icon`, and friends) with a single, generic
mechanism that works for every config entity type you have today and any you add
later, with no extra code.

Unlike most modules, this one **needs a little configuration before the picker
appears**: an admin chooses which entity types should get an icon picker on their
edit forms. After that, editing an entity of an enabled type shows an **Icon**
picker (placed in the *Additional settings* vertical tab when the form has one).
For rendering, the module ships a lightweight resolver service
(`config_entity_icon.resolver`) that reads and renders an entity's chosen icon from
a template or from PHP.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   make sure UI Icons and at least one icon pack are present.
2. [Configuration](configuration/index.md) — choose which config entity types get
   an icon picker.

## Where it lives in the admin menu

Its settings form sits at **Administration → Configuration → User interface →
Config Entity Icon**, where you tick the entity types that should receive an icon
picker. Once enabled for a type, the picker itself appears on the edit form of each
entity of that type.
