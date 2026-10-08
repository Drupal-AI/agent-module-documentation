<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Published-state block visibility conditions

Two `@Condition` plugins that gate a block by the published `status` of the node or taxonomy term
on the current route. Both extend one base class; there is no config, schema, permission, service,
route or hook beyond `hook_help()`.

## Install & enable

`drush en block_condition_published -y`. No dependencies (core only; `^9 || ^10 || ^11`). Nothing to
configure globally — the conditions appear on every block's **Visibility** settings.

## The plugins

- **`node_published_state`** — class `NodePublishedState`, context `entity:node` (`required = FALSE`),
  entity type id `node`.
- **`term_published_state`** — class `TermPublishedState`, context `entity:taxonomy_term`
  (`required = FALSE`), entity type id `taxonomy_term`.

Each subclass supplies only `getEntityTypeId()`; all behavior lives in
`PublishedStateConditionBase` (`src/Plugin/Condition/PublishedStateConditionBase.php`).

## Base class mechanics (`PublishedStateConditionBase`)

- `defaultConfiguration()` → `['is_published' => 0]` plus core defaults.
- `buildConfigurationForm()` renders a single **Published** checkbox (`is_published`) and `unset()`s
  the core `context_mapping` sub-form so the editor never picks a context manually.
- `submitConfigurationForm()` stores the checkbox and hard-wires the context mapping to the route
  context: `getRouteContextId()` builds `@node.node_route_context:node` (or the taxonomy-term
  equivalent) via `sprintf('@%1$s.%1$s_route_context:%1$s', getEntityTypeId())`. So the condition
  only resolves an entity on that entity type's canonical route.
- `summary()` interpolates the raw numeric `is_published` (`0`/`1`) through a `t()` `@state`
  placeholder — cosmetic wording only.

### `evaluate()` logic (lines 119–147)

1. If `is_published` is empty **and** the condition is not negated → return `TRUE` (unconfigured =
   never hides the block; an unchecked box is a no-op, not an "unpublished" filter).
2. Read the entity from context; if empty or `isNew()` → return `!isNegated()` (show, fail-open).
3. Load the **latest** revision: `getLatestRevisionId($entity->id())` then `loadRevision($vid)`, and
   return `latest_revision->get('status')->value == configuration['is_published']`.

`ConditionManager::execute()` then applies negation again to the returned value.

## Operating notes

- **Latest revision, not the rendered one.** Under content moderation a published node with a newer
  forward draft evaluates as unpublished. All non-published moderation states (Draft, Review,
  Archived) read as unpublished; only **Published** reads as published.
- **Canonical "drafts only" setup:** add the condition, check **Published**, and turn on the block
  UI's **Negate the condition** option. Leaving the checkbox blank does nothing (step 1 above).
- **Presentation, not access control.** A hidden block's markup is not rendered, but this does not
  govern who may view the entity — that remains entity/block access's job. Do not use it to protect
  anything.
