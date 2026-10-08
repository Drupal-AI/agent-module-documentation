# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal module dependencies. The module integrates the
  `Spiriitlabs/commit-history` PHP library, which Composer installs alongside it.
- Access to a **GitLab** or **GitHub** repository and an **access token** with
  permission to read its commits.

## Install with Composer

From the project root:

```bash
composer require drupal/commit_history -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, including the commit‑history library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commit_history -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commit_history -y
```

## Verify it worked

After enabling, configure the repository connection at **Configuration → Web
services → Commit history** (`/admin/config/services/commit-history`), then visit
**Reports → Commit history** (`/admin/reports/commit-history`) and confirm the
commit list appears. See [Configuration](../configuration/index.md).
