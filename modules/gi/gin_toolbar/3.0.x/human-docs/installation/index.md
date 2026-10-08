# Installation

## Requirements

- **Drupal 11.2** (`core_version_requirement: ^11.2`).
- The **Gin** admin theme (`drupal/gin`). Gin Toolbar is a companion to Gin and
  only activates when Gin — or a subtheme of it — is the active admin or default
  theme. Install the theme if you haven't already:

  ```bash
  composer require drupal/gin -W
  ```

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gin_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin_toolbar -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gin_toolbar -y
```

Then make sure **Gin** is set as your administration theme under **Appearance**
(`/admin/appearance`). Once Gin is active, the Gin‑styled toolbar appears on
front‑end pages for logged‑in users automatically — there is no configuration to
do. All appearance options come from the Gin theme's own settings.

There are **no submodules**.
