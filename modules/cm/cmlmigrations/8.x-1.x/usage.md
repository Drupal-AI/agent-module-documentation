<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CML Migrations imports CommerceML (1C) exchange data into Drupal Commerce products, variations and catalog taxonomy, driven by the Migrate framework and orchestrated through a Drush command.

---

CML Migrations (cmlmigrations) is the import side of a CommerceML / 1C:Enterprise exchange for
Drupal Commerce. The sibling module CML API (`cmlapi`) receives and parses the exchange XML; CML
Migrations consumes those parsed arrays through Migrate (migrate_plus + migrate_tools) and writes
them into `commerce_product`, `commerce_product_variation` and catalog taxonomy terms — with
variations linked to their product by a 1C UUID, per-warehouse stock and multi-price data optionally
imported as paragraphs. It depends on migrate_tools, migrate_plus, commerce_product, cmlapi and
yaml_editor, and is configured at `admin/structure/migrate/cmlmigrations`.

Migrations are run out of process: the status page, cron and the pipeline shell out to
`drush mim --group=cml` (via `shell_exec`, optionally with nohup), while a `cml` entity moves through
new → progress → success/failure states under a Drupal lock, with a cron watchdog that resets stuck
runs after an hour. All of its admin pages are gated by the `administer site configuration`
permission; it parses no XML itself and makes no outbound network calls of its own. This is a
developer/migration module — the imported data comes from the 1C exchange, so treat it as external
input.

---

- Import CommerceML (1C) catalog, product and variation data into Drupal Commerce.
- Consume cmlapi's parsed exchange arrays through the Migrate framework.
- Migrate catalog taxonomy terms into a configurable vocabulary.
- Import product variations and link them to their product by 1C UUID (`product_uuid` base field).
- Import per-warehouse stock into `field_stocks` paragraphs when stores are enabled.
- Import multiple price types into `field_prices` paragraphs when prices are enabled.
- Map imported product images from already-received local files to product image/gallery fields.
- Auto-detect a МойСклад (MoySklad) feed and adjust the image process steps accordingly.
- Configure the destination product/variation bundles and catalog vocabulary from a settings form.
- Edit each migration's source plugin and `process` pipeline as YAML in the admin UI.
- Run imports from the status page (Import / Update, optionally nohup) or from cron.
- Orchestrate runs via a `cmlmigrations` Drush command guarded by a Drupal lock.
- Track exchange progress through the `cml` entity's new → progress → success/failure state machine.
- Recover automatically from stuck migrations via a cron watchdog (1-hour timeout).
- Probe the environment (whoami / drush --version / nohup) from the status page.
- Unpublish all imported products or catalog terms and re-queue them for re-import.
- Fill or clear the variation `product_uuid` field in bulk before reinstalling or uninstalling.
- Store the exchange data as external input from 1C:Enterprise (treat as untrusted).
- Restrict all admin pages to users with `administer site configuration`.
- Import product descriptions as filtered `basic_html` body text.
- Use alongside cmlapi (exchange endpoint), cmlexchange (file receipt) and cmlstarter (structure).
- Support Drupal 9, 10 and 11.
