# Installation

## Requirements

Form Mode Manager needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- Core's **Field** (`field`) module, which is part of a standard install and is
  enabled automatically as a dependency.

There are no third-party libraries or contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/form_mode_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_mode_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_mode_manager -y
```

## Submodules — enable only what you need

Form Mode Manager ships three optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Form Mode Manager Examples** | `form_mode_manager_examples` | A demo content type with example form modes so you can try the feature quickly. Good for a test/dev site; you would not usually keep it on production. |
| **Form Mode Manager Theme Switcher** | `form_mode_manager_theme_switcher` | Lets you choose which theme is used when a given form mode is displayed (for example show a form mode using the admin theme). |
| **Form Mode User Roles Assign** | `form_mode_user_roles_assign` | Automatically assigns roles to users who register through a specific *user* registration form mode. |

For example:

```bash
drush en form_mode_manager_examples -y
```

Each submodule requires the base Form Mode Manager module, which is already present
once you have installed it above.

## Next steps

Enabling the module does nothing visible on its own — you have to create a form mode
and activate it on a bundle. Continue to [Configuration](../configuration/index.md)
for the full workflow.
