# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`), which is
  the only dependency and is enabled automatically.

There are no third‑party Composer or PHP library requirements. Note this release
is a beta (3.0.0‑beta3) and is not covered by Drupal's security advisory policy —
review it before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/group_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_sitemap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_sitemap -y
```

## Verify it worked

Visit `/group/{group}/sitemap.xml` for one of your groups (substituting the
group's ID). You should get an XML sitemap listing that group's publicly viewable
content. Confirm that content the anonymous user cannot see is absent from the
list.
