# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Webform](https://www.drupal.org/project/webform)** module (`^6.2`) —
  this is the only dependency, and the element is meaningless without it. Composer
  pulls it in for you if it isn't already present.

There are no third-party PHP library requirements — validation uses the Symfony
components already shipped with Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_iban_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Webform if you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_iban_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_iban_field -y
```

## Next steps

There is nothing to configure. Open a webform's *Build* tab, add the **Webform
IBAN field** element, and you're done — see
[How to use it](../index.md#how-to-use-it).
