# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`). The module was
  originally developed on Drupal 8.8+ and may not work on older versions.
- Individual **submodules** declare their own requirements — check each one before
  enabling it.

The base module has no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_toolbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_toolbox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_toolbox -y
```

## Submodules — enable only what you need

Decoupled Toolbox is deliberately modular. Enable the submodules for the
integrations you use:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Color Field support** | `decoupled_toolbox_color_field` | Exposes Color Field values in the JSON output. |
| **Decoupled Router support** | `decoupled_toolbox_decoupled_router` | Works with the Decoupled Router module to retrieve content based on aliased paths. |
| **Redirect support** | `decoupled_toolbox_redirect` | Exposes the entity's redirect values (Redirect module integration). |
| **Open API integration** | `openapi_decoupled_toolbox` | Lets you visualize and document your decoupled endpoints with Open API. |

For example:

```bash
drush en decoupled_toolbox_redirect openapi_decoupled_toolbox -y
```

## Recommended companion

- **Field Display Override** — lets you expose values that do not normally appear on
  the *Manage display* page (title, ID, created date, and so on). Install it if you
  need those in your JSON output.

## Verify it worked

Configure a **Manage display** view mode on one of your content types with the
fields you want to expose, then request the module's JSON path for an entity of that
type and confirm the output matches what you configured. If you enabled the Open API
submodule, use it to visualize the endpoints. Finally, review the exposed data
against your access rules — only public‑appropriate fields should be reachable.
