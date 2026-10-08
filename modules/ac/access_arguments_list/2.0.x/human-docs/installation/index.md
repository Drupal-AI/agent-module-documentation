# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present on a Drupal site.
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/access_arguments_list -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_arguments_list -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_arguments_list -y
```

There is nothing to configure. Visit **People → Permissions**
(`/admin/people/permissions`) and you will see each permission's machine name
printed under its description. Many teams enable this only on a development or
staging site as a reference aid.
