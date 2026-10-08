<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox — Decoupled Router add-on (decoupled_toolbox_decoupled_router) — agent index

Sub-module of **Decoupled Toolbox**. Enables filtering a collection by `path.alias`. Package **Decoupled**. Core `>=8`. GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `decoupled_toolbox`, `decoupled_router` (contrib).

## What it provides

- Service `decoupled_toolbox_decoupled_router.condition_preprocessor` = `AliasConditionPreprocessor` (event_subscriber), args `@entity_type.manager`, `@event_dispatcher`, `@http_kernel`.
- Subscribes to `FilterInterface::EVENT__CONDITION_PREPROCESS` (`ConditionPreprocessEvent`). `onConditionPreprocess()` ignores conditions whose field `f` is not `path.alias`; for `path.alias` it resolves the alias to an entity through Decoupled Router's `PathTranslator` and rewrites the condition to the entity type's id key.
- No routes, permissions, config, or Drush.

## Operate

Enable, then request e.g. `/decoupled-api/node/article/collection?filter[0][f]=path.alias&filter[0][v]=/my/alias`. See parent [api/endpoints.md](../../../1.6.x/agent/api/endpoints.md) for the filter syntax and event model.
