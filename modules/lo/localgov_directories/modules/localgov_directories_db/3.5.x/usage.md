<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories Database supplies the search backend for LocalGov Directories: a Search API **database** server plus the index configuration that makes directory channels searchable and facetable out of the box.

---

LocalGov Directories ships the index definition but no server, so on its own a channel page returns nothing. This submodule fills that gap with `search_api.server.localgov_directories_default` (the Search API database backend) and a matching index configuration held in `config/conditional/`. Its `hook_install()` deliberately does not just import config: it loads the existing `localgov_directories_index_default` index, and **only if that index currently has no server** does it copy the processors from the conditional YAML onto it, attach the `localgov_directories_default` server, set the index to enabled and save. That guard is what lets a site choose Solr instead — install Solr's server and point the index at it first, and this submodule will leave it alone; or, more commonly, uninstall this submodule before wiring Solr up. `hook_uninstall()` reverses the attachment so the index is not left pointing at a server that no longer exists. Everything else — fields, processors, facets — belongs to the parent module. Nothing here has a UI, permissions, schema or Drush commands; it is a pure config-provider submodule.

---

- Get directory search working immediately without configuring Search API by hand.
- Run a small council directory on the database backend rather than hosting Solr.
- Provide a development/CI search backend that needs no external service.
- Give a demo or training site a working directory out of the box.
- Bootstrap a directory index and switch to Solr later.
- Keep the index enabled and attached automatically on install.
- Avoid clobbering an already-configured search server thanks to the install guard.
- Uninstall cleanly, detaching the server without breaking the index.
- Reindex directory entries through the standard Search API commands.
- Test facet behaviour locally against the same index structure used in production.
- Provide search for a site where Solr is not permitted by hosting policy.
- Bring up a directory quickly for a proof of concept.
- Serve as the reference configuration when building a custom index.
- Support multi-site installs where each site has its own database index.
- Fall back to database search if the Solr server is unavailable.
- Keep the directory search stack entirely inside Drupal's database.
- Let editors preview directory search before infrastructure is provisioned.
- Simplify local development environments for LocalGov Drupal.
- Reduce the moving parts on a small site.
- Provide the index processors the parent module expects, pre-configured.
