# Slots — manual setup guide

**Slots** (`slots`) provides reusable content **placeholders** — "slots" — that
you can drop anywhere on your site, then let editors "push" content into them
based on configurable conditions, *without that content ever needing to live in
your site's exported configuration*. A slot is just a named identifier plus a
cardinality (how many blocks it may render); wherever you place that slot, any
content block flagged for it — and whose conditions match the current request —
appears there.

The problem it solves is a common tension in structured page building: you want a
fixed position in a layout (a call-to-action above a view, a promo in a default
layout, a flexible CTA inside a Paragraph) but you *don't* want that content
baked into configuration YAML and redeployed every time it changes. With Slots,
you place the placeholder once and editors fill or swap the content later,
entirely through the UI and driven by the reusable **conditions** system (request
path, language, role, a matching Slot condition, and so on).

Slots needs a small amount of setup before it does anything — you place a slot,
add a "Slots" field to a content block type, then create content blocks that
target the slot via conditions. It depends on three contrib modules:
**Block plugin view builder**, **Conditions** (its `conditions_field`
submodule), and **Dynamic Entity Reference**. Optional submodules extend where
slots can go: **Slots Views** (`slots_views`), **Slots Paragraphs**
(`slots_paragraphs`), and **Slots Twig** (`slots_twig`, which adds a `slot()`
Twig function). It works on Drupal 10 and 11 and is covered by Drupal's security
advisory policy.

On access: slot management is properly gated. The `administer slots` permission
(treat it as a restricted, trusted permission) manages slot entities; separate
permissions cover viewing the slot library, seeing where slots exist, and
creating slot IDs from the UI. Front-end rendering is read-only condition
evaluation with no anonymous mutation endpoints, so there is no risky public
surface here.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the full set-up workflow: place a
   slot, add the Slots field, and create the content that fills it.

## Where it lives in the admin menu

Slot entities are managed at **Content → Slots** (`/admin/content/slots`), gated
by the `administer slots` permission. You add the **Slots** field to block types
under **Structure → Block content types** (`/admin/structure/block-content`), and
you create the content blocks themselves under **Content → Blocks**
(`/admin/content/block`). Slots are placed either through **Block layout**, the
**Layout Builder** "+ Add slot" link, a View's header/footer, a Paragraph, or a
Twig template.
