# Installation

## Requirements

Layout Builder View Modes Overrides extends core Layout Builder. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it (and its own dependencies) automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_overrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_overrides -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_overrides -y
```

That's all it takes. There is no required configuration.

## Verify it worked

Go to a content type's **Manage display**, switch to a non‑default view mode (for
example *Teaser*), and enable **Use Layout Builder**. You should now also be
offered the option to let each content item customize its layout for that view
mode — the per‑entity override that core normally offers only on the default view.
