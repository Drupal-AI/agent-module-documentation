# Installation

## Requirements

Twig Field needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **CodeMirror Editor** module (`drupal/codemirror_editor` `^2`), which
  provides the in‑browser code editor the field's widget uses. Composer pulls
  this in automatically when you require Twig Field.

There are no other third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `drupal/codemirror_editor`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_field -y
```

Drupal enables the required **CodeMirror Editor** module at the same time as a
dependency.

## Grant the permission before you use it

Twig templates are effectively code, so entering or editing a template value is
locked behind the restricted **Create and edit templates stored in Twig fields**
(`access twig fields`) permission. At **People → Permissions**
(`/admin/people/permissions`), grant it to trusted administrator roles only — you
will see Drupal's "grant to trusted roles only" warning next to it. See the
[overview](../index.md#how-to-use-it) for how to add and configure the field.
