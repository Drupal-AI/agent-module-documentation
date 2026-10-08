# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- Core's **User** module (`user`) — always present on a Drupal site; it's the
  only dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_users -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_users -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_users -y
```

## Grant permissions

Purge Users ships two security-sensitive permissions (both restricted):

- **Access purge setting page** — reach the global settings form.
- **Access purge confirmation form** — run a purge from the confirmation screen.

Policy management additionally requires **Administer site configuration**. Grant
these only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`).

## Nothing runs until you turn it on

Every rule and the cron trigger are **disabled by default**, so enabling the
module changes nothing on its own. Head to
[Configuration](../configuration/index.md) to set up rules and trigger a purge.
