# Installation

## Requirements

- **Drupal 10.5 or newer, or Drupal 11** (`core_version_requirement: ^10.5 ||
  ^11`).

There are no other module dependencies and no third-party libraries — the parent
module is self-contained, and each submodule pulls in only what it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/bamboo_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. One Composer package delivers the parent module and all
nine submodules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bamboo_twig -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the parent module first (the submodules depend on it):

```bash
drush en bamboo_twig -y
```

On its own the parent registers no Twig function — it only provides the shared
base service. To actually get functions in your templates, enable the submodules
you need.

## Enable only the submodules you use

Each submodule adds one group of functions. Enable them individually so the Twig
runtime stays lean:

```bash
# Render/load blocks, entities, fields, views, menus, forms, images:
drush en bamboo_twig_loader -y

# Read config, settings.php, and state values:
drush en bamboo_twig_config -y

# Check permissions and roles:
drush en bamboo_twig_security -y
```

The full set of submodules is:

| Submodule | Machine name |
|-----------|--------------|
| Loader | `bamboo_twig_loader` |
| Config | `bamboo_twig_config` |
| Security | `bamboo_twig_security` |
| i18n | `bamboo_twig_i18n` |
| Token | `bamboo_twig_token` |
| File | `bamboo_twig_file` |
| Path | `bamboo_twig_path` |
| Cacheable | `bamboo_twig_cacheable` |
| Extensions | `bamboo_twig_extensions` |

Once a submodule is enabled its functions are immediately usable in any
`.html.twig` file — there is nothing to configure. See the module
[overview](../index.md) for which functions each submodule provides.
