# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **External Authentication** (`externalauth`) contrib module — this is the
  base it maps identities through. Composer installs it as a dependency.
- A **GitLab instance** (self-hosted or gitlab.com) where you can register an
  OAuth application.

## Install with Composer

From the project root:

```bash
composer require drupal/externalauth_gitlab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in External
Authentication and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/externalauth_gitlab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en externalauth_gitlab -y
```

Enabling it will also enable External Authentication if it isn't already on.

## Verify it worked

Visit **Configuration → People → External Auth GitLab settings**
(`/admin/config/people/externalauth-gitlab-settings`). The settings form should
load, ready for your GitLab application details. The module won't be able to log
anyone in until you complete [Configuration](../configuration/index.md) — you need
a GitLab OAuth application first.
