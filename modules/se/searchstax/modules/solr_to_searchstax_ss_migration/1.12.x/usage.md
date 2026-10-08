<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of **SearchStax**. Provides a one-off UI and Drush workflow for migrating an existing (non-SearchStax) Solr server's Search API configuration into SearchStax Site Search; meant to be uninstalled once the migration is done.

---

`solr_to_searchstax_ss_migration` is a helper that ships inside the `searchstax` project and depends on both `searchstax` and `search_api_solr`. It adds an admin overview at `/admin/config/search/solr-to-searchstax-ss-migration` listing the site's Solr Search API servers, a per-server migration form, and Drush commands that log into a SearchStax account, pick a target account/app, copy schema-relevant settings (languages, stopwords, synonyms, sorts, result/searched fields, optionally settings from a Views display) into a SearchStax app, and re-point the server (and optionally clone the index) at SearchStax. Because it drives the live SearchStax account API it needs a subscription and network access to run a real migration. It is intentionally temporary — the module docs say to uninstall it once migration is complete.

---

- Migrate an existing Solr Search API server's configuration to SearchStax Site Search.
- List which of the site's Search API Solr servers can be migrated (overview page).
- Migrate a single server interactively through the admin UI form.
- Migrate a server headlessly with `drush searchstax:migrate-server`.
- Copy languages, stopwords, synonyms, sorts and result fields into a SearchStax app.
- Copy selected settings from a Views search display into the SearchStax app.
- Set a valid SearchStax auth token for automated migration (`drush searchstax:set-auth-token`).
- Clone/copy a Search API index onto the newly migrated SearchStax server (`drush searchstax:copy-index`).
- Restrict a migration to specific language codes.
- Run migrations non-interactively in CI/deploy scripts with `--no-interaction`.
- Review the list of the SearchStax accounts and apps available to the logged-in token.
- Explicitly skip copying any Views settings by passing `--copy-from-view ""`.
- Target a specific SearchStax app by id with the `--app-id` option.
- Choose the destination SearchStax account by name with the `--account` option.
- Log into the SearchStax account API interactively from the migration form.
- Keep credentials out of the migration by reusing a token set via `set-auth-token`.
- Uninstall the submodule after the one-time migration is complete.
