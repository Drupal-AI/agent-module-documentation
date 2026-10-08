# Installation

## Requirements

- **Drupal 10.3, or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **CL Editorial** module (`cl_editorial`) and its **SDC Tags** submodule
  (`sdc_tags`) — SDC Display uses these to tag and filter which components appear
  in its pickers.
- The **`e0ipso/schema-forms`** PHP library (`^v2.5.1`), which builds the
  schema‑driven mapping forms. Composer installs it for you.
- Core's Single Directory Components support, which is part of Drupal 10.3+.

Composer resolves `cl_editorial`, `sdc_tags`, and the `schema-forms` library
automatically when you require the module with the `-W` flag.

## Install with Composer

From the project root:

```bash
composer require drupal/sdc_display -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
pull in `drupal/cl_editorial` and the `e0ipso/schema-forms` library at compatible
versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sdc_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sdc_display -y
```

Enabling SDC Display also enables `cl_editorial` and `sdc_tags` as dependencies.
The module itself ships no submodules.

## Verify it worked

Go to a bundle's **Manage display** screen (for example **Structure → Content
types → Article → Manage display**). Open the settings gear on a field, and you
should see an **SDC Display** section where you can choose a component. If your
component library exposes components tagged for use here, they will appear in the
picker.
