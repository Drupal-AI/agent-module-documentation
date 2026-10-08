<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Development is a submodule of acquia_cms_common that pre-wires Acquia Connector, Acquia Search, Shield and Google Maps from environment variables and relaxes caching on internal Acquia dev, IDE and local environments. It is a development/testing aid and is not meant for production.

---

The module does its work through a runtime config override service and an install hook, so it writes almost nothing to active config. On Acquia IDE environments it repoints Acquia Search at an internal dev Solr core, and on IDE or local environments it disables page caching and CSS/JS aggregation so changes show immediately. On install it reads CONNECTOR_KEY, CONNECTOR_ID, SEARCH_UUID, SHIELD_USER, SHIELD_PASS and GMAPS_KEY from the environment to seed Acquia Connector and Acquia Search credentials, optionally install and configure Shield on Acquia non-IDE environments, and set the Google Maps API key (including the Site Studio map form). Because it exists only to make Acquia's own development workflow convenient, enable it on dev/test/local, never on a live site.

---
- Point Acquia Search at an internal dev Solr core on Acquia IDEs.
- Disable page cache and asset aggregation while developing locally.
- Seed Acquia Connector credentials from environment variables.
- Seed Acquia Search credentials and host from the environment.
- Install and configure Shield on Acquia non-IDE environments.
- Supply a Google Maps API key for Place content and Site Studio maps.
- Provide a repeatable dev setup for Acquia CMS engineers.
- Keep development config out of the shipped distribution.
- Speed up local iteration on Acquia CMS sites.
- Configure integrations without manual admin steps.
- Support IDE-based development on Acquia Cloud.
- Avoid committing Acquia credentials by reading them from env vars.
