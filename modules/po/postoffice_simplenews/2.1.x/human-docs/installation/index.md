# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Postoffice** module together with its **Compat** (`postoffice_compat`) submodule.
- The contributed **Simplenews** (`simplenews`) module.

Composer resolves these dependencies for you with the `-W` flag below; the Postoffice
submodule is enabled as a dependency when you turn on Postoffice Simplenews.

## Install with Composer

From the project root:

```bash
composer require drupal/postoffice_simplenews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Postoffice and Simplenews and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/postoffice_simplenews -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en postoffice postoffice_compat simplenews postoffice_simplenews -y
```

## Turn it on for Simplenews mail

Point Simplenews's mail interface at the plugin:

```bash
drush config:set system.mail interface.simplenews postoffice_simplenews_mail
```

## Verify it worked

With Postoffice's transport configured, send a Simplenews test issue and confirm it arrives as a
themed, multipart Symfony message. See the [manual setup guide](../index.md) for theming and the
mail‑key details.
