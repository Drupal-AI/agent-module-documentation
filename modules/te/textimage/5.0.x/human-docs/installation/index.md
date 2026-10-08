# Installation

## Requirements

- **Drupal 11.3 or newer, or Drupal 12** (`core_version_requirement: ^11.3 || ^12`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The contrib **Image Effects** module version 5 (`drupal/image_effects:^5`) — this
  is what provides the "Text overlay" effect Textimage builds on. Composer pulls it
  in for you.
- **PHP GD2 and FreeType** libraries must be available in your PHP build — these do
  the actual text drawing.
- **At least one font file** the text effects can use. Register a default one on the
  settings form so overlays always have a font to render with.

## Install with Composer

From the project root:

```bash
composer require drupal/textimage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Image Effects and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/textimage -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en textimage -y
```

This also enables the Image and Image Effects modules if they are not already on.

## Verify it worked

Go to **Configuration → Media → Textimage** (`/admin/config/media/textimage`). If
the settings form loads, the module is active. Next, register a default font and set
your default output format there, then head to
[Configuration](../configuration/index.md) to build a template style and apply a
formatter.
