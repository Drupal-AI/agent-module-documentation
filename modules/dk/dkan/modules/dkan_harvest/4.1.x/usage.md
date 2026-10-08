<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pulls dataset catalogs from other open-data portals and registers them in the local metastore, so a site can aggregate external sources alongside its own.

---

Pulls dataset catalogs from other open-data portals and registers them in the local metastore, so a site can aggregate external sources alongside its own. Harvest operations are gated by their own permission set — `harvest_api_run`, `harvest_api_register`, `harvest_api_info`, `harvest_api_index`, and a dashboard permission — which lets a scheduled harvester be authorised for exactly the run and info verbs without any write access to datasets it did not harvest.

---

- Harvest a catalog from another portal.
- Register a harvest source.
- Run a harvest on schedule.
- Aggregate external datasets locally.
- Grant a harvester run-only access.
- Read harvest status via the API.
- Index harvested sources.
- View the harvest dashboard.
- Keep harvest verbs off general roles.
- Re-harvest a source to pick up changes.
- Mirror a federal catalog locally.
- Combine local and harvested datasets.
- Authorise a scheduled harvest job narrowly.
- Track what each harvest imported.
- Restrict harvest registration to admins.
- Feed harvested metadata into search.