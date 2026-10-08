# Installation

## Requirements

- **Drupal 10.5+, 11.2+, or 12** (`core_version_requirement: ^10.5 || ^11.2 || ^12`).
- The **BCA (Bundle Class Assistant)** module (`bca`), which Composer pulls in.

> **Development only:** this is an example module and is **not for production**.
> Install it on a learning or development environment. The current release is an
> alpha (1.0.0-alpha2).

## Install with Composer

From the project root:

```bash
composer require drupal/bundle_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bundle_classes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bundle_classes -y
```

Drupal enables the `bca` dependency at the same time. There is nothing to
configure — read the module's source to learn the bundle-class pattern, then
disable and remove it when you're done.
