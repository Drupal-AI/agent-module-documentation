<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pathauto Update (pathauto_update) — agent index

Extends Pathauto so a path alias is regenerated when the entity/config **behind its tokens**
changes — e.g. renaming a taxonomy term or a menu parent updates every alias built from it,
without a mass resave. It records each alias's token dependencies in a `path_alias_dependency`
table, watches entity/config CRUD, and regenerates affected aliases through two cron queues.

- Depends on `pathauto`, `token`, `url_entity` (all hard, from info.yml). Optional integration
  with `node_singles` (a provider that only activates when that module is present).
- Core `^9.4 || ^10 || ^11`, PHP `>= 8.0`. **No routes, no permissions, no settings page, no
  config, no custom drush commands.** All behavior is hook/queue-driven.

What you'd do:
- **Understand the services, entity, queues and runtime flow** → [api/services.md](api/services.md)
- **Add dependency tracking for a custom token type (or alter the built-in set)** → [plugins/pattern-token-dependency-provider.md](plugins/pattern-token-dependency-provider.md)
- **Process the regeneration queues (cron / drush)** → [drush/queues.md](drush/queues.md)

Key facts (real machine names):
- Content entity `path_alias_dependency` (base_table `path_alias_dependency`; fields
  `did`, `path_alias_id`, `dependency_type` (`entity`|`config`), `dependency_value`, `created`).
- Services: `pathauto_update.path_alias_dependency.repository`,
  `pathauto_update.path_alias_dependency.resolver`,
  `plugin.manager.pattern_token_dependency_provider`.
- Plugin type `PatternTokenDependencyProvider` (annotation `@PatternTokenDependencyProvider(type = "...")`,
  dir `src/Plugin/PatternTokenDependencyProvider`, interface `PatternTokenDependencyProviderInterface`,
  base `PatternTokenDependencyProviderBase`). Alter hook:
  `hook_pathauto_update_pattern_token_dependency_provider_info_alter`.
- Queue worker IDs: `pathauto_update_path_alias_dependency_updater` (resolves+stores deps),
  `pathauto_update_path_alias_updater` (regenerates one alias). Both run on cron (`time: 30`).
- Implements `hook_entity_insert/update/translation_insert/delete`; subscribes `ConfigEvents::SAVE`
  and `ConfigEvents::DELETE`. `hook_install` backfills deps for existing `taxonomy_term`, `node`,
  `media` + Pathauto's enabled entity types.
