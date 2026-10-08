# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Layout Builder Browser** module
  ([`layout_builder_browser`](https://www.drupal.org/project/layout_builder_browser))
  enabled — this is the module's one dependency, since it extends that module's
  block browser.

There are no third‑party Composer or PHP library requirements.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy. Weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_browser_block_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Layout Builder Browser is not already present, add it
too:

```bash
composer require drupal/layout_builder_browser -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_browser_block_library -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_browser_block_library -y
```

Drupal will enable Layout Builder Browser as a dependency if it is not already on.

## Verify it worked

Open a Layout Builder layout and click **Add block**. Next to the inline block
options provided by Layout Builder Browser you should now see a **Browse Block
Library** link. If it appears, the module is working.
