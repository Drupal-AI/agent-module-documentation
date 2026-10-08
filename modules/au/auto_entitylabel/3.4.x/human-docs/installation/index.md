# Installation

## Requirements

- **Drupal 10.1+ or Drupal 11** (`core_version_requirement: ^10.1 || ^11`).
- No required module dependencies — Automatic Entity Labels stands on its own.
- **Recommended: Token** (`drupal/token`) — only *suggested*, not required. It adds a token‑selection widget to the pattern field so you can browse and insert tokens instead of typing them by hand. If you plan to write anything beyond the simplest patterns, install it.

Automatic Entity Labels ships no submodules and needs no external PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_entitylabel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

To also pull in the recommended token browser:

```bash
composer require drupal/auto_entitylabel drupal/token -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auto_entitylabel -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_entitylabel -y
```

If you installed Token, enable it too:

```bash
drush en auto_entitylabel token -y
```

Enabling the module does nothing visible on its own — it only adds the **Automatic label** tab to your bundles and waits for you to configure one.

**Verify it worked.** Go to any content type's configuration page and look for an **Automatic label** tab — for example `/admin/structure/types/manage/article/auto-label`. If it's there, the module is active; head to [Configuration](../configuration/index.md) to set up a pattern.
