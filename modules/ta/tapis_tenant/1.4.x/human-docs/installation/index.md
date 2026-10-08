# Installation

## Requirements

TAPIS Tenant needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Key** module (`key`) — used to store tenant credentials securely.
- Core **Node**, **Field**, and **Content Moderation** (`content_moderation`).

Composer resolves and installs these dependencies for you. There are no extra PHP
or third-party library requirements. Note this release is a beta
(version 1.4.1-beta), so treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/tapis_tenant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Key and the other
dependencies as needed. (The Composer package name, `drupal/tapis_tenant`, matches
the module's machine name, `tapis_tenant`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tapis_tenant -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tapis_tenant -y
```

## Verify it worked

After enabling, you should be able to create **Tapis Site** and **Tapis Tenant**
content. Store each tenant's credentials as a Key (backed by an environment
variable) rather than as plain text. With a tenant defined, you can go on to
install **TAPIS Auth** and the rest of the TAPIS suite, which build on this
module.
