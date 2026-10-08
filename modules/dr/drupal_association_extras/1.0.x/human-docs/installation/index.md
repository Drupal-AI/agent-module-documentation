# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`) — this is a
  current‑Drupal module and will not install on older cores.
- Core's **Navigation** module (`navigation`), which Drupal enables automatically
  as a dependency when you turn on Drupal Association Extras.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drupal_association_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_association_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupal_association_extras -y
```

## Verify it worked

The module enables cleanly and pulls in core Navigation. Because this is an
`1.0.0-alpha1` release with almost no functionality yet, do not expect a new
settings page — check the admin **Navigation** for any link it contributes, and
follow the [project page](https://www.drupal.org/project/drupal_association_extras)
as features are added in later releases.
