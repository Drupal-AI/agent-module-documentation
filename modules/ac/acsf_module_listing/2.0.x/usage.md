<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ACSF Modules Listing lets an operator search which modules are enabled across the sites of an Acquia Cloud Site Factory (ACSF) environment, by calling the Acquia Cloud API for the site list and running `drush pm-list` over SSH on each site.

---

ACSF Modules Listing is an administrative reporting tool for Acquia Cloud Site Factory. You register one or more "ACSF Environment" config entities, each holding the SSH connection details (user, host, key paths, optional passphrase, drush path) and the Acquia Cloud API credentials (environment URL, username, API key) for a factory. From the Search form you choose an environment and type a module machine name or title; the module queries `{acsf_env_url}/api/v1/sites` for the environment's websites and then, per site, opens an SSH connection and runs `drush -l <site> pm-list` to gather enabled modules, matching them against your search term. Results are shown per site and cached for a configurable lifetime to speed up repeat searches. It requires the PHP SSH2 extension and an SSH key pair uploaded to Acquia Cloud. All screens are admin-gated (`administer site configuration` for the search/config screens, `administer acsf_environment_entity` for the environment entities); the module never exposes the current site's own module list to end users.

---

- Find every site in an ACSF environment that has a given module enabled.
- Audit contrib module usage across a large multi-site fleet before an upgrade.
- Locate sites still running a module with a pending security fix.
- Identify sites where a custom module is enabled so you can plan a refactor.
- Spot unnecessary modules to uninstall for performance/consistency.
- Register multiple ACSF environments (dev/stage/prod) as separate entities.
- Store per-environment SSH and Acquia Cloud API credentials in one place.
- Search by module machine name (e.g. `pathauto`) or by human title.
- Search several terms at once (space-separated) against the module list.
- Cache search results for a set lifetime to avoid repeated SSH round-trips.
- Force a fresh (uncached) search with the "Ignore cached results" checkbox.
- Configure the global cache lifetime under Configuration -> Web services.
- Manage environments under Structure -> ACSF Environment Entities.
- Enable/disable an environment entity without deleting its configuration.
- Run searches as a batch process across all sites of the environment.
- Report the module title and version for the first match per site.
- Verify module rollout consistency across the whole factory.
- Support Drupal 8, 9, 10, and 11 sites as the controlling instance.
- Drive the search purely from SSH + drush, no agent installed on target sites.
- Use per-environment Acquia Cloud API auth to enumerate factory sites.
- Give factory operators a single reporting entry point for module governance.
