A fully worked, runnable "beer" demo that migrates users, taxonomy terms, nodes and comments from example source tables to teach the core Migrate + Migrate Plus workflow.

---

Migrate Example is a teaching module: enable it and you get a complete `beer` migration group with four migrations (`beer_user`, `beer_term`, `beer_node`, `beer_comment`) plus custom source plugins in `src/Plugin/migrate/source/`. It demonstrates how to declare migrations as `migrate_plus.migration.*` config, how to group them, how to order them with `migration_dependencies`, and how process pipelines map source columns to destination fields. The companion hidden module `migrate_example_setup` creates the content type, fields, vocabulary and comment type the data lands in, and seeds the source tables. Reading its YAML and source classes is the fastest way to learn a real migration end-to-end. Run it with the Migrate Tools drush commands. It is a reference/learning aid, not something you keep enabled in production.

---

- Learn how a config-entity migration (`migrate_plus.migration.beer_node`) is structured.
- See a real migration group (`beer`) tie related migrations together.
- Study `migration_dependencies` ordering (users/terms before nodes before comments).
- Read a custom source plugin (`BeerNode`, `BeerUser`, `BeerTerm`, `BeerComment`).
- Understand mapping source fields to node/user/term/comment destinations.
- See how `default_value` and other process plugins are applied.
- Follow how a comment migration references its parent node.
- Inspect the destination `entity:node` / `entity:user` plugins in context.
- Copy the pattern to bootstrap your own custom-table migration.
- Practice `drush migrate:status` against a known-good group.
- Practice `drush migrate:import beer_node` and observe row counts.
- Practice `drush migrate:rollback` and re-import cycles.
- Learn how `migrate_example_setup` provisions destination config and source data.
- See how taxonomy term references are resolved during a node migration.
- Understand how menu links and path aliases fit a migration (deps on menu_ui, path).
- Use as a smoke test that Migrate + Migrate Plus are correctly installed.
- Diff old-Drupal migration style against Drupal 8+ config-based style.
- Serve as a template when onboarding new developers to migrations.
