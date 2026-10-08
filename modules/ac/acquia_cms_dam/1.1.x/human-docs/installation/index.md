# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **Acquia CMS Image** (`acquia_cms_image`) — a direct dependency, which itself
  depends on `acquia_cms_common`, so enabling DAM pulls in that chain.
- An **Acquia DAM** subscription and account credentials — required for the
  integration to do anything. See [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_dam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`acquia_cms_image` and the other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_dam -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_dam -y
```

Drush enables the dependency chain automatically. The module is enabled at this
point, but it won't fetch any assets until you supply your Acquia DAM
credentials — continue to [Configuration](../configuration/index.md).
