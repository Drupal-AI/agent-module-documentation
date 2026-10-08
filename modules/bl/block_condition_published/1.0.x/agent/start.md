<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Condition Published (block_condition_published) — agent index

Two block **visibility conditions** keyed on the **published status** of the node or taxonomy
term on the current route. Version **1.0.0-beta1** — beta. Core requirement `^9 || ^10 || ^11`.
No dependencies, no config schema, no permissions, no services.

## What it provides

Two `Condition` plugins sharing `PublishedStateConditionBase`:

- **`node_published_state`** (`NodePublishedState`) — context `entity:node` (not required), resolved
  from `node.node_route_context`.
- **`term_published_state`** (`TermPublishedState`) — context `entity:taxonomy_term` (not required),
  resolved from `taxonomy_term.taxonomy_term_route_context`.

Both are added to a block through the standard block layout UI (administer blocks). No global settings.

Solution docs: [`plugins/conditions.md`](plugins/conditions.md) — the two condition plugins, base-class
mechanics, `evaluate()` logic, and the canonical setups.

## Mechanism (`PublishedStateConditionBase`)

- **Config:** one checkbox, `is_published` (default `0`). `buildConfigurationForm()` renders it and
  `unset()`s the core `context_mapping` sub-form; `submitConfigurationForm()` hard-wires the context
  mapping to the route-context id (`@node.node_route_context:node`, etc.).
- **`evaluate()`:**
  1. If `is_published` is empty **and** the condition is not negated → return `TRUE` (unconfigured =
     never hides the block). So leaving the checkbox blank is a **no-op**, not an "unpublished" filter.
  2. Read the entity from context; if empty or `isNew()` → return `!isNegated()` (fail-open: show).
  3. Load the entity's **latest** revision via `getLatestRevisionId()` + `loadRevision()` and return
     `latest_revision->get('status')->value == configuration['is_published']`.
  Negation is then applied again by `ConditionManager::execute()` (the manager negates the result), so
  the manual `isNegated()` branches interact with automatic negation — the practical effect is
  fail-open on the no-entity / unconfigured paths.
- **`summary()`:** prints the raw numeric `is_published` value (`0`/`1`) into the text — cosmetic only.

## Semantics to keep straight

1. **Presentation, not access.** A block hidden on unpublished content is not rendered, so its markup is
   genuinely not sent — but this says nothing about whether the visitor may see the entity itself, which
   is **entity access's** job. Never use this to protect anything; the block's content stays separately
   access-controlled.
2. **Latest revision, not the rendered one.** `evaluate()` inspects the latest revision's `status`, which
   under content moderation can be a forward draft that differs from the default revision on screen. All
   non-published moderation states (Draft, Review, Archived) read as "unpublished".
3. **Canonical setup:** to show a block only on drafts, add the condition and use the block UI's
   **Negate the condition** option (with **Published** checked) rather than trying to express it with the
   checkbox alone.

Compare `user_not_role` (wave 78) and other condition plugins filling core visibility gaps.
