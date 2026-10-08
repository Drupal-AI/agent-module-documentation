# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **IMCE** module (`imce`) — this is the module's only dependency, and it is
  the file browser whose folder access this module adjusts. Install and enable IMCE
  first (or let Composer and Drush pull it in).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/imce_multiple_roles_folders -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imce_multiple_roles_folders -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce_multiple_roles_folders -y
```

Drupal will enable IMCE automatically if it is not already on.

## Verify it worked

Give a test account two roles whose IMCE profiles grant different folders, then log
in as that user and open an IMCE browser (for example from a file/image field or a
CKEditor image dialog). You should see the folders from **both** roles' profiles
combined. If the module were off, you would see only a single profile's folders.
