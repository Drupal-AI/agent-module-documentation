# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No module dependencies and no third‑party PHP libraries. FDK builds on core's
  Field UI and Twig field rendering.

> **Theme compatibility:** FDK provides its own `field.html.twig`. If any of your
> active themes override `field.html.twig`, make sure that override extends **FDK's**
> template rather than core's, or FDK's output settings may not take effect.

## Install with Composer

From the project root:

```bash
composer require drupal/fdk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fdk -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fdk -y
```

## Verify it worked

Go to any bundle's **Manage display** (for example **Structure → Content types →
*(type)* → Manage display**) and open a field's formatter settings. You should see
FDK's extra controls — label text and tag, field and item wrappers, and item
linking. Set one, save, and view the entity to confirm the field renders as
configured.
