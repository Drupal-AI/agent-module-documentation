# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No modules beyond core are required. The formatter works on **Link**,
  **Entity reference**, and **File** fields, so you'll want at least one such
  field on the entity you plan to redirect.

The settings form's token-picker link is a little nicer if the contrib **Token**
module is installed, but Token is **not** a hard dependency — the module works
fine without it.

## Install with Composer

From the project root:

```bash
composer require drupal/field_redirection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_redirection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_redirection -y
```

There are no submodules.

## Verify it worked

Go to a content type's **Manage display**, switch to the **Full content** view
mode, and open the format dropdown for a link, entity-reference, or file field.
You should see **Redirect** as an available formatter. See
[How to use it](../index.md#how-to-use-it) on the overview page for configuring
it (and remember: use it only on the Full content view mode).
