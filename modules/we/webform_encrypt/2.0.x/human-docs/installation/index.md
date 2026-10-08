# Installation

## Requirements

Webform Encrypt sits on top of two other contributed modules, which Composer pulls
in for you:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Webform** 6.2 or newer (`drupal/webform:^6.2`) — the form builder itself.
- **Encrypt** 3.x (`drupal/encrypt:3.*`) — manages encryption profiles.
- Indirectly, the **Key** module (a dependency of Encrypt) is used to hold the
  actual encryption key, so you can store it outside the database (for example in
  an environment variable or a file).

## Install with Composer

From the project root:

```bash
composer require drupal/webform_encrypt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Webform,
Encrypt, and their shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_encrypt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_encrypt -y
```

Drush enables Webform and Encrypt automatically because they are declared
dependencies. There are no submodules.

## Next step

Before you can encrypt anything you need an **encryption profile** to exist (that
is an Encrypt-module concept, and it in turn points at a Key). Head to
[Configuration](../configuration/index.md), which walks through creating the
profile and then switching encryption on for an element.
