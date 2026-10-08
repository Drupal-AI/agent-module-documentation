# Installation

## Requirements

ECA Commerce sits on top of two other projects, so both must be present:

- **Drupal 10.4+ or 11.2+** (`core_version_requirement: ^10.4 || ^11.2`).
- **PHP 8.1 or newer**.
- **[ECA](https://www.drupal.org/project/eca)** `^2.1.11 || ^3.0` — the automation
  engine (`drupal/eca`).
- **[Commerce](https://www.drupal.org/project/commerce)** `^2 || ^3`
  (`drupal/commerce`).

You'll also want an ECA **modeller** so you can build models visually — the
maintainers recommend the BPMN modeller. Composer pulls in ECA and Commerce as
declared dependencies; add a modeller separately if you don't already have one.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — important here, since ECA and Commerce bring their own
dependency trees.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/eca_commerce -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable ECA Commerce along with ECA and the Commerce components you use. For
example:

```bash
drush en eca_commerce -y
```

Drush will pull in `eca` and `commerce` as dependencies. Enable the specific
Commerce submodules (cart, checkout, payment, promotion, …) you plan to build
workflows around — the matching event groups only appear once their submodule is
installed.

## Configuration

There's no settings page to configure. All behavior lives in **ECA models** you
build in your modeller — see [How to use it](../index.md#how-to-use-it). There are
no submodules in this project.
