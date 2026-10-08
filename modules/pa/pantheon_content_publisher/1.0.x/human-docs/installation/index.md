# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2 – 8.5**.
- The **Search API** module (`search_api`, >= 8.x-1.20) — Composer installs it for
  you with the `-W` flag below.
- A **Pantheon Content Publisher** account, with a collection set up in the Content
  Publisher dashboard and an **access token** to authenticate with.
- The **Key** module (`key`) is strongly recommended so the access token is stored
  as a secret rather than in configuration (see Configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/pantheon_content_publisher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Search API.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pantheon_content_publisher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pantheon_content_publisher -y
```

Drupal enables Search API automatically as a dependency.

## Verify it worked

Log in as an administrator and go to **Structure → Pantheon Content Publisher
Collection**. If you can reach the collection admin, the module is installed.
Before it can pull content, work through [Configuration](../configuration/index.md)
to store your access token, create a Search API server, and add a collection.
