Bulk-generates dummy Drupal Commerce content (product types, products, product variations and orders) through the Devel Generate framework, via an admin form or a Drush command.

---

Devel Generate Commerce is a developer/testing tool that registers a `commerce` Devel Generate plugin. From a settings form at `admin/config/development/generate/commerce` or the `drush devel-generate:commerce` command (alias `gencom`), it creates the requested number of Commerce product types (each with a matching variation type), products with randomly-titled variations priced in a configurable min/max range, and orders that reference random variations and are assigned random workflow states. A default Commerce store is auto-created if none exists. You choose the counts, the price range, how far back the created/placed timestamps should be spread, which order workflow and states to use, and whether to delete every existing product, product type, variation and order first (`kill`). It is intended purely for local/dev environments to seed a store with sample catalogue and order data; it has no runtime/front-end behaviour of its own and depends on Commerce, Devel and Devel Generate.

---

- Quickly seed a fresh Commerce store with a catalogue of demo products for local development.
- Generate a batch of product types plus their variation types so displays and views have data to render.
- Populate variations with random prices between a chosen minimum and maximum to test price formatting and currency handling.
- Create a set of dummy orders to exercise the cart, checkout and order administration screens.
- Assign generated orders random states drawn from a chosen order workflow to test workflow-dependent views and reports.
- Spread the `created`/`placed` dates of generated content randomly across a chosen time range (now, an hour, a day, a week, a month, a year ago) to test date-based sorting and reporting.
- Reset a dev store by ticking `Delete all?` (or passing `--kill`) to wipe existing commerce entities before regenerating.
- Produce sample data for demoing a Commerce build to stakeholders without hand-entering products.
- Load-test listing pages, Views and search indexes with up to 100 products/orders per run.
- Create test fixtures for manual QA of catalogue, cart and checkout flows.
- Generate variations flagged as always-in-stock so orders can be placed without configuring stock.
- Auto-provision a default `online` store (USD, example address) when a store does not yet exist, so generation works on a blank install.
- Script repeatable data seeding in setup scripts using the Drush command and options (e.g. `--products_num`, `--orders_num`).
- Override individual amounts from the CLI, e.g. `drush devel-generate:commerce --products_num=10` while keeping other defaults.
- Restrict order generation to specific statuses by passing `--order_statuses` a comma-separated state list.
- Provide realistic content for theming work on product and order templates.
- Benchmark import/indexing performance by generating large batches of commerce entities.
- Seed data for automated functional tests of Commerce-dependent modules.
- Populate a staging environment with anonymised-style dummy orders instead of copying production data.
- Exercise tax/adjustment display: each generated order gets a dummy tax adjustment with a random amount.
- Generate multiple variations per product to test attribute/variation selection widgets.
- Give evaluators a one-command way to see a populated store when trying out a Commerce distribution.
