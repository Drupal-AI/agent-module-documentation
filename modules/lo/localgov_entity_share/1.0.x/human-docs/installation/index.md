# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entity Share** module — specifically its client component
  `entity_share_client` (from the `drupal/entity_share` project). Installing this
  module pulls it in, and enabling this module also enables the client.
- A **LocalGov Drupal** site is the intended context.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_entity_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Entity Share and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_entity_share -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_entity_share -y
```

Enabling it also enables the Entity Share client (`entity_share_client`).

## Verify it worked

Open Entity Share's administration and confirm you can configure a **remote** and
its content channels. A successful setup lets you define a trusted source site and
pull content from it via JSON:API. Remember to store remote credentials securely
and only connect to source sites you trust.
