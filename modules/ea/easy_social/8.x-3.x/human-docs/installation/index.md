# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **No other module dependencies** — Easy Social relies only on Drupal core.

There are no third‑party Composer or PHP library requirements. Note, however,
that the share widgets themselves load JavaScript from the social networks at
render time — see the privacy note in [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/easy_social -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_social -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_social -y
```

After enabling, grant the **Administer Easy Social** (`administer easy_social`)
permission to the roles that should manage the widgets, then visit the settings
form.

## Submodules

Easy Social ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Easy Social Example** | `easy_social_example` | A ready-made example configuration that demonstrates how the widgets are set up and placed. Handy on a development site for reference; not needed on production. |

```bash
drush en easy_social_example -y
```

## Verify it worked

Go to **Configuration → Web services → Easy Social**
(`/admin/config/services/easy-social`). If the per-network settings form loads,
the module is installed correctly. Configure your networks there, then check a
node (or the block/View where you placed the widgets) on the front end to confirm
the share buttons appear.
