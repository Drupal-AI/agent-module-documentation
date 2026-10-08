<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SearchStax — agent index

Integrates Drupal with SearchStax hosted Solr / SearchStudio Site Search: a `search_api_solr`
connector for the managed cluster, plus front-end search tracking, analytics, auto-suggest,
and flood protection. Depends on `search_api` (indexing also needs `search_api_solr`).

- Machine name: `searchstax` · configure route: `searchstax.admin_settings`
  (`/admin/config/search/searchstax`), permission `administer site configuration`.
- Live indexing / analytics / version-check need a SearchStax subscription + network access.

## Capabilities

- **[Configure site-wide behaviour](configure/searchstax.md)** — the `searchstax.settings`
  config object (analytics key/URL, tracking opt-out, EU Cookie Compliance, flood protection,
  SearchStudio re-routing, JS version), the three admin forms/routes, the `searchstax` Solr
  connector plugin, and how to set config with `drush`.
- **[Call the module programmatically](api/searchstax.md)** — the `searchstax.api` account
  API service, the `searchstax.utility` (SearchStax) tracking/query service, and how to detect
  a SearchStax Solr server.

## Submodule

- **solr_to_searchstax_ss_migration** — one-off UI + Drush workflow to migrate a generic Solr
  server into SearchStax. Documented separately at
  `../../modules/solr_to_searchstax_ss_migration/1.12.x/agent/start.md`.
