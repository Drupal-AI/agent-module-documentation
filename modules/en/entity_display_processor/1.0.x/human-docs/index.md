# Entity Display Processor — manual setup guide

**Entity Display Processor** (`entity_display_processor`) introduces a new plugin
type — an **"Entity display processor"** — that lets you alter and decorate how an
entity is rendered, per view mode. The idea is to turn what would otherwise be
one‑off `hook_entity_view_alter()` implementations scattered through a project into
**reusable, configurable plugins** that can be selected on a view mode and even
shipped as part of contributed modules.

The kinds of effects a processor plugin can apply include adding a CSS effect to the
rendered entity (a shadow, a background color), adding a custom CSS class to the
entity's HTML element, wrapping the entity in an expand/collapse box, or applying a
dynamic effect driven by the entity's own field values (for example a colored frame
whose color comes from a field). The module ships only a few example plugins — the
intent is that you write more for your specific project, theme, or in‑house
ecosystem.

You can achieve similar results with Display Suite or core Layout Builder, but this
module lets you add an effect that's **independent of the layout**. It's a
developer/content‑display framework: plugins affect rendering and it has no content
or access role of its own. It targets **Drupal 11**. Note this project is **not
covered by the security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** — you select and configure a processor per
view mode on **Manage display**, described in "How to use it" below. Writing new
processor plugins is done in code.

## Where it lives in the admin menu

The module adds no page of its own. You choose a display processor on a view mode's
**Manage display** screen — for example
`/admin/structure/types/manage/page/display/teaser` for the *page* content type's
*teaser* view mode (assuming that type and view mode exist).

## How to use it

1. Go to the **Manage display** screen for the entity type, bundle, and view mode
   you want to affect (for example *page* → *teaser*).
2. Scroll to the **bottom of the form**, where you can choose and configure **up to
   one** entity display processor plugin for that view mode.
3. Configure the chosen plugin's options and save.
4. When an entity is viewed in that view mode, the plugin's effect is applied to its
   rendered output.

To go beyond the few bundled examples, implement your own entity display processor
plugins in a custom module, theme, or contrib project.
