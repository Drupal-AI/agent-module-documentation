<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Install Core (drd_install_core) — agent index

Submodule of **Drupal Remote Dashboard** that provisions a new site from a **Webform** submission
and registers it with the dashboard. Package `DRD`. Core `^10 || ^11`, GPL-2.0-or-later. Depends on
`drd`, `webform`, `gitlab_api`.

- **The webform handler, element, event subscriber and field mapping** →
  [plugins/install-core.md](plugins/install-core.md)

## What it actually is

- **Webform handler** `InstallCore` (`@WebformHandler(id = "drd_core")`, label "DRD Core
  Installer") in `src/Plugin/WebformHandler/InstallCore.php`. On `postSave()` of a completed new
  submission it creates a `drd_core` and a `drd_domain`, seeds `shared_secret` auth + `OpenSsl`
  crypt from its configuration, and writes a "domain secrets" JSON blob into a submission field.
- **Webform element** `Domain` (`@WebformElement(id = "drd_domain")`) in
  `src/Plugin/WebformElement/Domain.php` — a thin subclass of Webform's `Url` element for entering
  the new site's URL.
- **Event subscriber** `CreateProject` (`src/EventSubscriber/CreateProject.php`, service
  `drd_install_core.create_project.event_subscriber`) — reacts to `gitlab_api`'s
  `GitLabEvents::CREATEPROJECT` and stores the new repo's `ssh_url_to_repo` on the matching
  `drd_core` (`Core::setGitRepo()`).
- **Shipped config**: `config/install/webform.webform.add_new_drupal_site.yml` (an example intake
  webform). No routes, permissions, config schema or Drush of its own.

## Data flow

Submission → `InstallCore::postSave()` → `Core::create()` (+ `drupalroot`) →
`Domain::instanceFromUrl()` → set header/auth/crypt/installed → save → build `field_domain_secrets`
JSON (authorised uuid, auth + crypt settings, dashboard IPs, timestamp) → resave submission. The new
site's DRD Agent later consumes that payload to trust this dashboard.
