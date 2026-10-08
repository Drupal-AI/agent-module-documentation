<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pathauto Update regenerates a URL alias when the entity or config *behind its tokens* changes — so renaming a taxonomy term, an author, a menu parent, or the site name updates every alias whose Pathauto pattern references it, without a manual mass resave.

---

Pathauto builds an alias from a token pattern at save time and then never revisits it: a pattern like `[node:field_category:entity:name]/[node:title]` produces `/health/flu-advice`, and renaming the Health term to Wellbeing leaves every alias built from it silently stale, because nothing resaved those nodes. This module closes that gap by tracking dependencies. Whenever a path alias is created or changed, `PathAliasDependencyResolver` scans its pattern's tokens and a set of `PatternTokenDependencyProvider` plugins (one per token type — `node`, `menu-link`, `site`, `date`, `url`, `entity`, `array` join-paths, and optionally `node_singles`) work out which entities and config objects the alias's value derives from; `PathAliasDependencyRepository` stores those as `path_alias_dependency` rows. Then `hook_entity_*` and the config `SAVE`/`DELETE` subscribers watch for changes to any tracked dependency and enqueue the affected aliases for regeneration. Two cron queue workers do the actual work — `pathauto_update_path_alias_dependency_updater` collects/refreshes the dependency records and `pathauto_update_path_alias_updater` re-runs Pathauto on each affected entity and clears its cache tags — so regeneration is asynchronous and needs cron (or a manual `drush queue:run`) to complete. It has no settings page, permissions, or custom drush commands; its hard dependencies (`pathauto`, `token`, `url_entity`) are functional, and `hook_install` backfills dependency records for existing taxonomy terms, nodes and media. The main operational caveat is scale: renaming a widely-used term can cascade into regenerating thousands of aliases, and because the module replaces aliases in place, enable Pathauto's own "create a redirect" update action if the old URLs still matter for SEO.

---

- Update aliases when a referenced taxonomy term is renamed.
- Keep child-node URLs correct after a menu parent moves or is retitled.
- Refresh aliases built from `[site:name]` when the site name changes.
- Avoid an expensive mass resave to fix stale aliases.
- Track which entities and config an alias's tokens depend on.
- Regenerate affected aliases automatically on cron.
- Fix stale aliases site-wide after a rebrand.
- Keep multilingual aliases in step with translated dependencies.
- Update aliases when a node's author (`[node:author]`) changes.
- Refresh aliases using a `[date:*]` token when the date format changes.
- Support a deep term-based or menu-based URL structure that stays accurate.
- Add a dependency provider for a custom token type.
- Alter or remove a built-in token dependency provider.
- Backfill dependency records for all existing content at install time.
- Regenerate after a bulk term edit once cron drains the queue.
- Drain the regeneration queues manually with `drush queue:run`.
- Keep aliases consistent when a menu link title or URL changes.
- Update aliases that reference a Node Singles single.
- Reduce SEO damage from silently wrong paths.
- Detect exactly which aliases a given entity/config change affects.
- Pair with Pathauto redirects so old URLs keep resolving.
- Keep `[…:join-path]` hierarchical aliases correct as the menu tree changes.
