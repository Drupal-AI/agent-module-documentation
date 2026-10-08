# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies and no third‑party PHP library requirements. To
make use of the module you'll want at least one piece of content to reference as a
custom 404 page (and its translations, if you serve multiple languages).

## Install with Composer

From the project root:

```bash
composer require drupal/conditional_404_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conditional_404_pages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conditional_404_pages -y
```

After enabling, grant the module's permissions (**People → Permissions**) to the
site builders/administrators who should manage conditional 404 pages.

## Verify it worked

Create a conditional 404 page (see [Configuration](../configuration/index.md))
pointing at a content item and a path pattern such as `/my-section/*`, then
request a non-existent URL under that section (for example
`/my-section/does-not-exist`). Your chosen content should be displayed as the 404
page.
