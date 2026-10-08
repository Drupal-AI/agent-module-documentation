# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, and no third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/createandcontinue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/createandcontinue -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en createandcontinue -y
```

There is nothing to configure — once enabled, the save-and-create-another button
appears on every node form.

## Verify it worked

Open any node-add form. Alongside the normal **Save** button you should see the
module's extra button. Click it, fill in and save a node, and confirm you're returned
to a fresh empty form of the same content type (and that the confirmation message names
the node you just saved).
