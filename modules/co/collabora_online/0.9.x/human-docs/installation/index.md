# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core **Media** (`media`) and the **Key** module (`key`), which Composer/Drupal
  pull in as dependencies.
- A **Collabora Online server** to connect to — either the community edition
  (CODE) or a paid licensed Collabora Online server. This runs outside Drupal and
  must be reachable from your site. It does not have to be dedicated to this
  install.

## Install with Composer

From the project root:

```bash
composer require drupal/collabora_online -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including Media and Key, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/collabora_online -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en collabora_online -y
```

## Submodules

- **`collabora_online_group`** — adds integration with the **Group** module, so
  document access can follow group membership. Enable it only if your site uses
  Group:

  ```bash
  drush en collabora_online_group -y
  ```

## Stand up a Collabora Online server

The module is only the Drupal-side integration; you also need a running Collabora
Online (CODE or licensed) server it can reach. Set that up separately following
Collabora's own documentation, and note its URL and the shared secret you will use
to sign WOPI tokens — you will enter both in [Configuration](../configuration/index.md).

## Verify it worked

After enabling and configuring the server connection, open a document media item in
Drupal. If everything is wired up, it should render inside the Collabora viewer/editor
in the browser rather than downloading.
