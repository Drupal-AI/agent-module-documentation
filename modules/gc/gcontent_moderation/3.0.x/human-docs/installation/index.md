# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Content Moderation** module (`content_moderation`) — the workflows this
  module makes group‑aware.
- The **Group** module (`drupal/group` ^3.3) — enabled with at least one group type
  configured.

Content Moderation is a core module; the Group module is pulled in by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/gcontent_moderation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Group module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gcontent_moderation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gcontent_moderation -y
```

Make sure Content Moderation and Group are both set up first. There are no
submodules. After enabling, there is no settings form to visit — instead you
configure a workflow and grant group permissions, as described in
[Configuration](../configuration/index.md).
