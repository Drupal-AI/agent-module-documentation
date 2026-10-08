# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Smart Content** (`smart_content`) and its **Smart Content Blocks**
  (`smart_content_block`) submodule.
- The **js_cookie** library/module (`js_cookie`).
- The `pantheon-systems/pantheon-edge-integrations` PHP library — Composer pulls
  it in automatically, and **Smart Content CDN will not function without it**.
- A **Pantheon environment with Edge Integrations enabled** — this module is
  specific to Pantheon's edge platform.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_content_cdn -W
```

The Composer package name (`drupal/smart_content_cdn`) matches the module's
machine name (`smart_content_cdn`). Requiring it installs Smart Content, Smart
Content CDN and the `pantheon-edge-integrations` PHP library all at once. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_content_cdn -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_content_cdn -y
```

Drupal enables Smart Content, the block submodule and js_cookie at the same time,
since they are dependencies.

## Next step

Once enabled, you must configure the module before it does anything — turn on the
Vary header and set your default geo value. See
[Configuration](../configuration/index.md).
