# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **REST** module (`rest`) — this is the module's one dependency, and it
  provides the base Serializer style that Pager Serializer extends. Drupal enables
  it automatically as a dependency.
- No third-party Composer or PHP library requirements.

You will also want the core **Views** module (enabled on standard installs) and a
View with a **REST export** display to apply the style to.

## Install with Composer

From the project root:

```bash
composer require drupal/pager_serializer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pager_serializer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pager_serializer -y
```

Drupal will enable core's REST module along with it if it is not already on.

## Verify it worked

Edit a View with a REST export display and open its **Format** settings — **Pager
serializer** should now appear as a style option alongside "Serializer". You can
also confirm the settings form loads at **Configuration → Web services → Pager
Serializer** (`/admin/config/pager_serializer`). See the
[overview](../index.md#how-to-use-it) for how to apply and configure it.
