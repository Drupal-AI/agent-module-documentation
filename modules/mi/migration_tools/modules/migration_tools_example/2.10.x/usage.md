A demonstration submodule of Migration Tools that ships runnable example migrations showing how to use the `dom` data parser, Obtainers and standard process plugins; copy and adapt them for your own migration module.

---

Enabling `migration_tools_example` installs a `migration_tools_example` migration group plus two example migrations into config: `mt_example_dom_import` (scrapes a live URL with `source: plugin: url` + `data_parser_plugin: dom`, chunking the DOM into rows with `ObtainLinkFile` and running a `basicCleanup` source modifier) and `mt_example_drupal_import`. Their config lives in `config/install/` (registered as config on enable, so they appear in the Migrate UI and export with `drush cex`). The submodule also ships non-config example migration YAML under a `migration/` directory (`node_sample_csv.yml`, `media_pdf_sample_csv.yml`) that illustrate CSV-source imports; those are reference files, not auto-registered config. The migrations declare an enforced module dependency so they are removed on uninstall. The submodule provides no code, services, routes, permissions or plugins of its own — it is purely example configuration to learn the parent module's `dom_config.migration_tools` field/obtainer/job syntax. Enable it only in a development environment; the URL-scraping example fetches a real external site when run.

---

- Learn the `dom_config.migration_tools` fields/obtainer/jobs syntax from a working example.
- See how to chunk a single fetched page into multiple migration rows using an Obtainer.
- Copy `mt_example_dom_import` as a starting point for a URL-scraping migration.
- Copy `mt_example_drupal_import` as a starting point for an HTML-file import.
- Study how a `basicCleanup` source modifier is wired into a DOM migration.
- Reference `node_sample_csv.yml` for a CSV-to-node migration skeleton.
- Reference `media_pdf_sample_csv.yml` for a CSV-to-media (PDF) migration skeleton.
- See how a migration group is defined and shared across example migrations.
- Confirm Migration Tools + Migrate Plus are wired correctly by running the examples in dev.
- Inspect the examples in the Migrate UI / `drush migrate:status` to understand registration.
- Use the examples as a template for `ObtainLinkFile` / `findFileLinksHref` link extraction.
- Demonstrate the `url` source + `http` data fetcher + `dom` data parser combination.
- Show teammates how Migration Tools is meant to be consumed before writing a custom migration.
- Compare config-based vs `migration/`-directory example migrations.
- Bootstrap a proof-of-concept scrape against a known URL.
