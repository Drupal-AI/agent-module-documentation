# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`), which matches
  when Single Directory Components became available in core.
- Core's **SDC** support must be active and working within your theme — this module
  reads and renders your theme's Single Directory Components.
- To get full rendered previews, your components need a `.story.twig` file so they
  can be rendered with sample data.
- No third-party Composer or PHP library requirements, and no dependent contrib
  modules.

## Install with Composer

From the project root:

```bash
composer require drupal/sdc_component_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdc_component_library -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sdc_component_library -y
```

Once enabled, the module reads all the SDCs from your theme folder. No further
configuration is strictly required to see the component list.

## Verify it worked

Grant your account the **`access sdc component library`** permission (see
[Configuration](../configuration/index.md)), then visit `/sdc-component-library`.
You should see the list of components discovered in your theme; components with a
`.story.twig` file render with dummy data.
