# Installation

## Requirements

This starter kit needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Schema.org Blueprints** suite — `schemadotorg` and its
  `schemadotorg_starterkit` submodule.
- **Config Rewrite** (`config_rewrite`) and core's **Menu UI** (`menu_ui`).

Drupal will enable these dependencies for you when you turn on the module, but if
you install with Composer the package brings the Schema.org Blueprints project in
as well. There are no extra PHP or third-party library requirements.

Because a starter kit installs configuration into the site, run it on a **fresh or
evaluation site** rather than an established production site.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg_starterkit_organization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg_starterkit_organization -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg_starterkit_organization -y
```

Enabling it scaffolds the Organization and LocalBusiness content types and their
Schema.org mappings.

## Verify it worked

Go to **Structure → Content types**. You should see the new **Organization** and
**LocalBusiness** types, each with its required fields already in place. Add a
piece of content of one of those types and the page will emit the corresponding
Schema.org structured data.
