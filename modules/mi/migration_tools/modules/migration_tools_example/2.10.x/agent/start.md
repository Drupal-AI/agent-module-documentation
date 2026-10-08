# Migration Tools Example — agent index

Demonstration submodule of **Migration Tools** (parent docs:
[../../../../2.10.x/agent/start.md](../../../../2.10.x/agent/start.md)). No code, services, routes,
permissions or plugins — it only ships example migration configuration to learn the parent's DOM/Obtainer
syntax. `configure` = null.

What enabling it installs (`config/install/`):
- `migrate_plus.migration_group.migration_tools_example` — the example group.
- `mt_example_dom_import` — URL scrape: `source: plugin: url`, `data_fetcher_plugin: http`,
  `data_parser_plugin: dom`; chunks a page into rows via `ObtainLinkFile` + a `basicCleanup` modifier
  under `dom_config.migration_tools`.
- `mt_example_drupal_import` — companion import example.

Non-config reference files (`migration/` dir, not auto-registered): `node_sample_csv.yml`,
`media_pdf_sample_csv.yml` — CSV migration skeletons.

Notes:
- Dev-only. Running `mt_example_dom_import` fetches a real external URL.
- For the plugins/helpers these examples use, read the parent's
  [plugins](../../../../2.10.x/agent/plugins/migrate.md) and
  [extend/obtainers](../../../../2.10.x/agent/extend/obtainers.md) docs.
