# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — this is the module's one dependency, and it
  is enabled on standard installs. Drupal enables it automatically if needed.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_ef_fieldset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_ef_fieldset -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_ef_fieldset -y
```

On install the module registers its display extender globally, so the grouping
option becomes available on every view's **Exposed form** settings — no further
setup is required.

## Verify it worked

Edit any view with exposed filters at **Structure → Views**
(`/admin/structure/views`), open its **Exposed form** settings, and look for the
**"Enable fieldset around exposed forms?"** checkbox. See the
[overview](../index.md#how-to-use-it) for how to build the grouping.
