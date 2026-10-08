# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no extra PHP library requirements.
- An **ORCID account and a registered ORCID OAuth application** (for the client ID
  and secret).

## Install with Composer

From the project root:

```bash
composer require drupal/orcid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orcid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orcid -y
```

## Verify it worked

Confirm the module is enabled (`drush pml | grep orcid`) and review its permissions
under **People → Permissions** (`/admin/people/permissions`). Then register your
ORCID OAuth application and configure its credentials — see
[Configuration](../configuration/index.md).
