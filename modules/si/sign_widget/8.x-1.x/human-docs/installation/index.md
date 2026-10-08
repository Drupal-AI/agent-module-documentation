# Installation

## Requirements

- **Drupal 8.8, 9, 10, 11, or 12** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11 || ^12`).
- Core's **Image** module (`image`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements — on Drupal 8+ the
signature-pad JavaScript is loaded from a CDN, so you do not download any library
by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/sign_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sign_widget -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sign_widget -y
```

There is no settings form to visit afterwards. You configure the signature
capture per field, in the entity's *Manage form display* — see
[How to use it](../index.md#how-to-use-it) in the main guide.
