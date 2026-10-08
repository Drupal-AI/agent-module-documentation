# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No modules outside Drupal core are required.

There are no third‑party PHP or JavaScript library requirements.

> **Project status:** this project is marked **unsupported / obsolete** on
> Drupal.org at the documented version. It still works as described, but weigh that
> before adopting it on a new site.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_label -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_label -y
```

## Verify it worked

Edit any bundle — for example a content type at **Structure → Content types →
*(type)* → Edit**. You should see a new **Label settings** group where you can enter
the singular/plural and article forms. Filling those in and using the
`entity_label()` Twig function or the `[…:label:…]` tokens (see
["How to use it"](../index.md)) confirms the module is working.
