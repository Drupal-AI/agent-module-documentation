# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **IMCE** module (`imce`) — the file browser this plugin extends. Composer
  installs it for you and Drupal enables it as a dependency.
- The PHP **mbstring** extension (`ext-mbstring`) — used for the multibyte-safe name
  handling. It is present in almost every PHP build.

There are no other third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/imce_rename_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `imce`
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imce_rename_plugin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce_rename_plugin -y
```

IMCE is enabled automatically if it is not already on. There are no submodules.

## Next steps

Enabling the module adds the *Rename files* and *Rename folders* checkboxes to IMCE
profiles, but the Rename button will not appear until you grant one of them on a
folder. Follow the [How to use it](../index.md#how-to-use-it) steps to grant the
permissions in **Configuration → Media → IMCE** and assign the profile to the right
roles.
