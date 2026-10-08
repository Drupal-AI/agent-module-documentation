# Installation

## Requirements

Webform Score needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Webform** module (`drupal/webform` `^6.0`) — the forms it scores.
- The **Fraction** module (`drupal/fraction` `^2 || ^3`) — used to store the score
  as an exact numerator/denominator.

Composer pulls both dependencies in automatically. There are no other third‑party
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_score -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `drupal/webform` and
`drupal/fraction`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_score -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_score -y
```

Drupal enables the required **Webform** and **Fraction** modules at the same time.

There is no configuration form to visit. Instead, add **Quiz** elements to a webform
and set the score‑visibility permissions — see the
[overview](../index.md#how-to-use-it).
