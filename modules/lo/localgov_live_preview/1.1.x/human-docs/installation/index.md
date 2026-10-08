# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- For the actual live-preview feature, a **LocalGov Microsites** platform: the
  **LocalGov Live Preview Microsites** submodule depends on
  `localgov_microsites_group` and `localgov_microsites_colour_picker_fields`, so those
  must be present.

This is an **experimental** module (the current release is a 1.1.x beta), part of the
LocalGov Drupal (Experimental) package. Treat it as an editing convenience for
non-production or carefully-tested environments.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_live_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_live_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The base module on its own only carries the off-canvas tray theming. To get the
feature, enable the microsites submodule (which brings in the base module and its
microsites dependencies):

```bash
drush en localgov_live_preview_microsites -y
```

If you only want the shared tray theming for building your own submodule, enable just
the base module instead:

```bash
drush en localgov_live_preview -y
```

## Verify it worked

After enabling the microsites submodule, grant the **Use live preview** permission on
**People → Permissions**, then view a microsite node as a permitted user. An **Edit
Microsite Design** tab should appear; clicking it should open the design form in an
off-canvas tray with changes previewing live.
