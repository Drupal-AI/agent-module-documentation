# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** and **System** modules (`file`, `system`) — always present on a
  standard install; the module extends the File and Image field widgets.
- No third-party Composer or PHP library requirements.

The **IMCE** file browser source is optional. It only appears when the
[IMCE module](https://www.drupal.org/project/imce) is installed and the user has
access to it.

## Install with Composer

From the project root:

```bash
composer require drupal/filefield_sources -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/filefield_sources -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filefield_sources -y
```

## Optional: the IMCE source

To offer the IMCE file browser as a source, install and enable IMCE as well:

```bash
composer require drupal/imce -W
drush en imce -y
```

Once IMCE is present, a **File browser** source becomes available in the File
sources list for users who have IMCE access.

## Verify it worked

Go to a bundle's **Manage form display** (for example
`/admin/structure/types/manage/article/form-display`), click the gear on a **File**
or **Image** field, and look for the **File sources** section. If it is there, the
module is working. See [Configuration](../configuration/index.md) for how to enable
the sources.
