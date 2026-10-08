# Installation

## Requirements

Plupload Integration provides a Form API upload element. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`, and it requires
  `drupal/core: ^10.3 || ^11`).
- Core's **File** module (`file`) enabled — this is its only module dependency, and
  Drupal will enable it automatically as a dependency.

The Plupload JavaScript library is bundled through the module's own library
definition, so there is no separate download step. There are no other PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/plupload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plupload -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plupload -y
```

Once enabled, the `#type => 'plupload'` form element is available to any custom
module — see the module's [overview page](../index.md#how-to-use-it-developers) for
how to add it to a form.

## Optional: the demo submodule

The bundled **`plupload_test`** submodule provides a ready‑made demo form at
`/plupload-test`, handy for confirming the element works and for seeing a complete
submit‑handling example:

```bash
drush en plupload_test -y
```

Leave it disabled on production sites — it's only a demonstration/QA form.

## Configuration

The module has one advanced setting (`temporary_uri`) that most sites never need to
change. See [Configuration](../configuration/index.md).
