# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** module (`filter`) — enabled by default and declared as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/links_to_iframes_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/links_to_iframes_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en links_to_iframes_filter -y
drush cr
```

## Verify it worked

Go to **Configuration → Content authoring → Links to iframes**
(`/admin/config/content/links-to-iframes`). You should see the screen for adding
link→iframe replacements. The next step is to add a mapping and enable the
**Replace links with iframes** filter on a text format — see
[Configuration](../configuration/index.md).
