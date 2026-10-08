# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Queue UI** module (`queue_ui`) — enabled automatically as a dependency;
  it drives the import/delete queues.
- A **Communico account** with API access — you need an **access key** and
  **secret key** to configure the module.

There are no additional third‑party PHP library requirements.

> **Note:** this project is developed on GitHub
> (`github.com/earlyburg/communico_plus`), which is the upstream repository.

## Install with Composer

From the project root:

```bash
composer require drupal/communico_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, including Queue UI.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/communico_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en communico_plus -y
```

Enabling it also enables **Queue UI**, and installing it creates the `event_page`
content type and its `field_communico_*` fields.

## Verify it worked

Confirm the **Event page** content type now exists under **Structure → Content
types**, then go to **`/admin/config/communico_plus/api`** to enter your
Communico credentials. Continue with [Configuration](../configuration/index.md).
