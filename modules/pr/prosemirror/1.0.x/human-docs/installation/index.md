# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

ProseMirror has no other module dependencies.

> **Note:** the 1.0.x branch is a beta release (1.0.0‑beta2) and the project is under
> active development. Test it on a non‑production environment before rolling it out
> widely.

## Install with Composer

From the project root:

```bash
composer require drupal/prosemirror -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prosemirror -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prosemirror -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit a text format. If **ProseMirror** appears
in the **Text editor** drop‑down, the module is installed. See "How to use it" on the
[overview page](../index.md) for attaching it to a format.
