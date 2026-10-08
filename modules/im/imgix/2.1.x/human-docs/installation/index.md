# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- Core's **File** module (`file`) — the only dependency, enabled automatically.
- An **Imgix account** with at least one configured **source**, and (recommended)
  a **secure URL token** for signing transformations. You create these in the Imgix
  dashboard; the module needs the source's domain and the token.

## Install with Composer

From the project root:

```bash
composer require drupal/imgix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imgix -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imgix -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) and enter your
Imgix source. Then add or edit an image field's **Manage display**, switch its
format to the Imgix formatter, and view a piece of content that uses the field —
the image's URL should now point at your Imgix source domain rather than your
site's own `/files` path.
