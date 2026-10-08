# Installation

## Requirements

- **Drupal 8 or higher** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Backup and Migrate — AWS S3** (`backup_migrate_aws_s3`) — a required module
  dependency, and it must have an S3 destination configured for the deploy
  workflow to work.
- A **Git repository** for your site with a **GitHub or GitLab** remote (the
  module detects the remote to build the launch URL).

There are no additional third‑party Composer or PHP library requirements beyond
the Backup and Migrate AWS S3 dependency (which Composer resolves for you).

## Install with Composer

From the project root:

```bash
composer require drupal/drupalforge_deploy -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the required
`backup_migrate_aws_s3` dependency and updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupalforge_deploy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupalforge_deploy -y
```

## Configure the prerequisites

Before the Deploy page will let you launch, set up **Backup and Migrate** with an
**AWS S3** destination (see that module's own documentation), and make sure your
site lives in a Git repository with a GitHub or GitLab remote. Then grant the
module's permission to the trusted roles who should be allowed to deploy, at
**People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Open **Configuration → Development → Drupal Forge Deploy**
(`/admin/config/development/drupalforge-deploy`). The page's readiness steps will
tell you whether your Git and Backup‑and‑Migrate/S3 configuration is complete.
Once everything checks out, you can select a branch and backup and deploy — see
[How to use it](../index.md#how-to-use-it).
