# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) enabled — the only dependency, and Drupal will
  enable it automatically as a dependency when you turn on Media Ubicast.
- An **Ubicast** account with videos you want to embed. The videos are hosted and
  streamed by Ubicast; Drupal only references and displays them.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_ubicast -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_ubicast -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_ubicast -y
```

## Verify it worked

Go to **Structure → Media types → Add media type** and check that **Ubicast**
appears in the **Media source** dropdown. If it does, the source is registered and
you can create an Ubicast media type as described in "How to use it" on the
[overview page](../index.md).
