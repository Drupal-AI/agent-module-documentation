# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Webform** module, version `^6.3@alpha` (`drupal/webform`). Composer pulls it
  in automatically with the command below, but note it is an alpha release — you may
  need to allow it through your project's `minimum-stability` settings.
- Core's **RESTful Web Services** module (`rest`), enabled as a dependency.
- Recommended: the **REST UI** module (`drupal/restui`) — an optional UI for enabling
  and configuring REST resources without editing config by hand.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_rest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Webform — as needed. To also install the optional UI for managing resources:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_rest -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_rest -y
```

Enabling the module registers the five REST resource plugins but does **not** activate
any of them — that is a separate, deliberate step. Continue to
[Configuration](../configuration/index.md) to turn on the resources you need, grant
the right permissions, and set the confirmation‑response option.

Webform REST ships no submodules.
