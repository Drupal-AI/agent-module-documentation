# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- A **Raisely account** with API credentials.

There are no additional Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/raisely -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/raisely -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en raisely -y
```

## Verify it worked

After enabling, open the module's settings to enter your Raisely API credentials, as
described in [Configuration](../configuration/index.md). Once the credentials are in
place, the module can connect to the Raisely API.

> **Note:** Raisely is under active development, so exact screens and options may
> evolve between releases. Check the module's project page if a setting does not match
> what you see.
