<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Forge Deployment (drupalforge_deploy) — agent index

Experimental (**0.0.x pre-release**, `lifecycle: experimental`, packaged `version: 0.0.0`) module
that builds a **Drupal Forge "DrupalPod" launch URL** from the local Git repository, the running
PHP version, and a **Backup and Migrate AWS S3** backup. No entities, no plugins — a single admin
form plus supporting services. Package: none. License GPL-2.0-or-later. Core `^8 || ^9 || ^10 || ^11`.

- **Dependencies:** `backup_migrate_aws_s3` (declared in info.yml as
  `backup_migrate_aws_s3:backup_migrate_aws_s3`), which transitively requires `backup_migrate`.
  The code hard-references the `backup_migrate_destination` entity type and `backup_migrate.*` routes.
- **Requires** a Git checkout with a **public GitHub or GitLab remote** (private repos unsupported yet)
  and an AWS S3 Backup and Migrate destination with at least one backup.

## Routes (both require permission `administer drupalforge deploy`, `restrict access: true`)

- `drupalforge_deploy.deploy` → `/admin/config/development/drupalforge-deploy`
  (`_form` = `DrupalForgeDeployForm`; `configure` target; menu under *Config → Development*).
- `drupalforge_deploy.git_reference_autocomplete` →
  `/admin/config/development/drupalforge-deploy/git-reference-autocomplete`
  (`_controller` = `GitReferenceAutocompleteController::autocomplete`).

## Services (from `drupalforge_deploy.services.yml`)

- `git_repository_inspector` — `GitRepositoryInspector`: shell-out `git` inspection of the local repo.
- `git_provider_detector` — `GitProviderDetector`: HTTPS probe to classify a host as GitLab.
- `backup_catalog_service` — `BackupCatalogService`: discovers/normalizes backups via the provider.
- `backup_metadata_provider` — `BackupMigrateDestinationMetadataProvider`: reads AWS S3 destinations.
- `deployment_url_builder` — `DeploymentUrlBuilder`: assembles the launch fragment URL.
- `php_image_resolver` — `PhpImageResolver`: PHP version → `drupalforge/deployment:php-<x.y>`.
- `backup_option_formatter` — `BackupOptionFormatter`: select options for the form.
- `deploy_readiness_evaluator` — `DeployReadinessEvaluator`: overall ready / failure reasons.
- `logger.channel.drupalforge_deploy` — module log channel.

## Config, permission, hooks

- Config schema `drupalforge_deploy.settings` with one key `deployment_env_vars` (text). No `config/install`.
- One permission: `administer drupalforge deploy` (restricted).
- `hook_help()` via `DrupalForgeDeployHooks::help()` (OOP `#[Hook]` + `#[LegacyHook]` shim in `.module`).
- Two internal JS libraries (`step_navigation`, `deploy_sync`); no external front-end libraries.

## Solution docs

- **The deploy form, four-step wizard & readiness evaluation** → [forms/deploy-form.md](forms/deploy-form.md)
- **The Git-reference autocomplete controller & route** → [api/git-autocomplete.md](api/git-autocomplete.md)
- **All services (Git inspector, provider detector, backup catalog/metadata, URL builder, image resolver, formatter, readiness)** → [api/services.md](api/services.md)
- **Install, routes, permission & config schema** → [config/settings.md](config/settings.md)
