<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Remote Dashboard (DRD) is a central control plane that monitors and manages any number of remote Drupal sites from one place.

---

DRD turns one Drupal install into a "dashboard" that inventories a fleet of remote Drupal sites (called domains, grouped into cores and hosts) and drives administrative operations on them over an encrypted HTTP channel. Each managed site runs the companion `drd_agent` module, which receives commands from the dashboard, executes them locally, and returns results. From the dashboard you can pull status/health reports, list installed projects and available updates, flush caches, toggle maintenance mode, run cron and update.php, execute arbitrary PHP or shell/script snippets, download database dumps, open a remote admin session, and orchestrate full code-update pipelines (build → process → test → deploy → finish) with storage backends such as Git and rsync. Actions run interactively, from Drush/Drupal Console, via cron, through the Advanced Queue background processor, or automatically from ECA rules (via the `drd_eca` submodule). Sensitive per-domain values (authentication secret and encryption key) are stored encrypted at rest through the Encrypt module and an admin-selected encryption profile.

---

- Register a remote Drupal site as a `drd_domain` and connect it to its `drd_agent` for remote management.
- Group multiple domains that share one codebase under a `drd_core`, and group cores by server as a `drd_host`.
- Pull each site's status report (requirements) and surface warnings and errors on the dashboard.
- List installed projects (`drd_project`) and their releases (`drd_release`) across the whole fleet.
- Detect which sites have pending security or feature updates via the core `update` integration.
- Flush caches on one or many remote sites in a single operation.
- Enable or disable maintenance mode on remote sites.
- Trigger cron runs and run `update.php` (database updates) remotely.
- Execute an ad-hoc PHP snippet on a remote site (`drd_action_php`) for maintenance tasks.
- Run shell, Drush, Drupal Console, or Python scripts on remote sites via configurable Script and Script Type entities.
- Download a remote site's database dump to the dashboard (`drd_action_database`).
- Open an authenticated one-time session ("jump") into a remote site's admin without knowing its password.
- Discover all sibling domains hosted on the same remote core and import them automatically (`drd_action_domains_receive`).
- Run a full remote code-update pipeline (Composer / Drush Make / Direct build, Git or rsync storage, rsync deploy).
- Lock/unlock releases and automatically lock releases flagged as "hacked" by the Hacked! module.
- Queue long-running actions for background processing with Advanced Queue instead of blocking the request.
- Tag actions with taxonomy terms and fire a whole set of tagged actions against selected entities at once.
- Automate fleet operations by reacting to `drd.action.started` / `drd.action.finished` events in ECA (`drd_eca`).
- Bulk-import a legacy DRD 7 inventory of sites with the `drd:migratefromd7` Drush command (`drd_migrate`).
- Provision brand-new sites from a webform submission and wire them to the dashboard (`drd_install_core`).
- Manage sites hosted on Acquia, Pantheon and Platform.sh through the DRD PI submodules.
- Restrict who can run which remote action using per-action permissions.
- Clean up unused releases, major versions and projects automatically during cron.
