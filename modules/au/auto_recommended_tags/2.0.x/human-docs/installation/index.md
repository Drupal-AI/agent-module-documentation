# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Taxonomy** module (`taxonomy`), enabled — Drupal enables it
  automatically as a dependency.
- A running **Apache Stanbol** server with its enhancement engines, reachable
  from your site/browser over a WebSocket. This is an external service the module
  connects to; it is not bundled.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_recommended_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_recommended_tags -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_recommended_tags -y
```

## After enabling

- Grant the **`administer auto recommended tags settings`** permission to the
  roles that should configure the integration, at **People → Permissions**.
- Point the module at your Apache Stanbol server, as described in
  [Configuration](../configuration/index.md).
- Test the WebSocket connection after configuring the endpoint, and best pair the
  feature with a curated taxonomy vocabulary.
