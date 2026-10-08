# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer libraries are required. The optional client‑side validation
  uses the jQuery Rut plugin, which ships with the module.
- The **RUT Field** submodule additionally requires core's **Field** module (enabled
  by default on standard installs).

## Install with Composer

From the project root:

```bash
composer require drupal/rut -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rut -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rut -y
```

That gives you the `rut_field` **form element** and the `Drupal\rut\Rut` helper class
for use in custom code.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **RUT Field** | `rut_field` | A storable **field type** you can add to content types and other entities through the UI, with a widget, formatter, a uniqueness constraint, a per‑field *Bypass validation* setting, and integration with Feeds, Views, and the Devel generator. |

Enable it only if you want a RUT field you can attach to entities:

```bash
drush en rut_field -y
```

It requires the base **Rut** module, which is already present once you've installed
the above.

## Verify it worked

Confirm **Rut** is enabled at **Extend** (`/admin/modules`). If you enabled the RUT
Field submodule, go to a content type's **Manage fields → Add field**
(**Structure → Content types → *(your type)* → Manage fields**) and confirm **RUT**
appears in the list of available field types.
