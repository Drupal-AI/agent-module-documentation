Specialized migration examples that go beyond the basic beer demo — showing remote/URL sources, XML parsing and other advanced Migrate Plus features.

---

Migrate Example (Advanced) collects the trickier patterns that don't fit the introductory `migrate_example`. It demonstrates using the `url` source with data parsers (e.g. XML) to pull structured data, more elaborate process pipelines, and integration points such as REST (its setup module depends on `rest`). Like the basic example it declares migrations as `migrate_plus.migration.*` config and provides custom source plugins, paired with the hidden `migrate_example_advanced_setup` module that provisions the destination structures and fixtures. It is a reference for developers who already understand the basics and need to see how remote feeds, wrapped data and dependent migrations are wired. Run it with the Migrate Tools drush commands; it is a learning aid, not for production.

---

- See a `url`-source migration pulling from a structured feed.
- Learn how the XML / SimpleXML data parser maps nodes to fields.
- Study `item_selector` and `fields[].selector` for hierarchical source data.
- Understand advanced process pipelines beyond simple field copies.
- See how a REST-backed source is configured (setup depends on `rest`).
- Follow more complex `migration_dependencies` between example migrations.
- Read custom advanced source plugins in `src/Plugin/migrate/source/`.
- Copy patterns for importing from an external API into content.
- Contrast the advanced example against the basic beer example.
- Learn how the advanced setup module provisions destination config.
- Practice `drush migrate:import` / `migrate:rollback` on non-trivial data.
- Understand data transformation when the source shape differs from the target.
- Reference when building a real remote-feed importer.
- See how sub-item / nested data is flattened into rows.
- Use as a template for XML/RSS ingestion migrations.
- Onboard developers to advanced Migrate Plus source configuration.
