# Entity Reference Deck — manual setup guide

**Entity Reference Deck** (`entity_reference_deck`) gives entity reference fields
a consistent **card‑and‑toolbar editing experience**. Each referenced item is
shown as a "deck card" with pluggable toolbar actions — things like moderation
status, usage, revision diff, and more — so editors get a uniform UI for
browsing, reordering, and editing referenced entities, without a bespoke widget
being built for every site.

Rather than replace Entity Browser or Paragraphs, it layers card "chrome" and
action toolbars on top of them. The core module supplies the plumbing (action,
meta, and group plugin managers, a card builder, a global settings form, and
Single Directory Components such as `erdeck-card`, status tags, and usage
badges). You then enable **host** submodules for the widget you use and **feature**
submodules for the extras you want:

- **Host — Entity Reference Deck EB** (`entity_reference_deck_eb`): Entity
  Browser field widgets (optionally a multi‑launcher with Entity Browser Multi).
- **Host — Entity Reference Deck Paragraphs** (`entity_reference_deck_paragraphs`):
  a Paragraphs field widget with closed‑row chrome.
- **Feature — Diff** (`entity_reference_deck_diff`): a revision‑compare action and
  modal (requires the Diff module).
- **Feature — Usage** (`entity_reference_deck_usage`): usage surfaces (requires
  Entity Usage).
- **Feature — Moderation** (`entity_reference_deck_moderation`): Content
  Moderation‑aware card styling.
- **Feature — Paragraphs Library** (`entity_reference_deck_paragraphs_library`):
  library‑item theming (requires the Paragraphs host and Paragraphs Library).
- **Preview** (`entity_reference_deck_preview`): live front‑end preview of
  referenced entities in cards (needs iframe‑resizer installed on the site — see
  [Installation](installation/index.md)).
- **Skin — Gin** (`entity_reference_deck_gin`): remaps the module's `--erdeck-*`
  design tokens when the Gin admin theme is active.

The core module works even without Diff, Entity Usage, Content Moderation, or
Paragraphs Library installed. There is **no new content type** — you configure it
through the module's global settings form plus each field's *Manage form display*
widget. It targets **Drupal core 11.4** and **PHP 8.3+**, and depends only on
core's **Field** module (host/feature packages are required only when you enable
the matching submodule).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the core
   module and the host/feature submodules you need, and (for Preview) install
   iframe‑resizer.
2. [Configuration](configuration/index.md) — the global settings form (action
   groups, meta items, card defaults) and the per‑field widget setup.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Entity
Reference Deck**. Per‑field setup happens on each bundle's **Manage form display**
(**Structure → Content types → *(type)* → Manage form display**), where you set
the entity reference field's widget to an ER Deck host widget.
