<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Search Database supplies the Search API database server behind LocalGov's sitewide search and attaches the `localgov_sitewide_search` index to it — the zero-configuration backend option for sites that do not run Solr.

---

The parent module ships the index but no server, so search returns nothing until a backend exists. This submodule installs `search_api.server.localgov_sitewide_search` (the database backend) and, in `hook_install()`, wires the two together — but only when it is safe to do so. The guard is precise: it acts only if config is **not** currently syncing, the `localgov_sitewide_search` index exists, **and** that index currently has an empty server id. When those hold it copies the processors from its own `config/conditional/` copy of the index definition onto the live index, attaches the server, enables the index and saves. A site already pointed at Solr therefore survives an accidental install untouched. `hook_uninstall()` detaches the server again so the index is not left referencing something that no longer exists. There is no UI, no permissions, no schema and no Drush commands — it is a config-provider submodule whose whole purpose is making search work out of the box.

---

- Get LocalGov sitewide search working with no extra infrastructure.
- Run search on the database for a small council site.
- Provide a working search backend in local development.
- Give CI a search backend that needs no external service.
- Bootstrap search now and migrate to Solr later.
- Avoid clobbering an existing Solr configuration when installing.
- Detach the server cleanly on uninstall.
- Supply the index processors the parent module expects.
- Demo LocalGov Drupal search without provisioning Solr.
- Keep the whole search stack inside Drupal's database.
- Reduce moving parts on a low-traffic site.
- Reindex through the standard Search API commands.
- Serve as reference configuration for a custom backend.
- Support multi-site installs with per-site indexes.
- Provide a fallback when the Solr service is unavailable.
- Enable search during initial site build before infrastructure lands.
- Keep search configuration deployable as config.
- Test index processor behaviour locally.
- Let editors preview search results early in a build.
- Simplify onboarding for new LocalGov developers.
