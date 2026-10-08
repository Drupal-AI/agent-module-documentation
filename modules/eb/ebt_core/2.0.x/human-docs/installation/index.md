# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Block Content** (`block_content`) and **Media** (`media`) modules.
- Two contributed modules, pulled in automatically by Composer:
  **Field Group** (`drupal/field_group ^3.0 || ^4.0`) and **Media Library Form
  Element** (`drupal/media_library_form_element ^2.0`).
- Four front-end JavaScript libraries that back the color picker, parallax, and
  background-video features, also declared as Composer requirements:
  `levmyshkin/jquery-colorpicker`, `levmyshkin/jquery-mb-ytplayer`,
  `levmyshkin/parallaxjs`, and `levmyshkin/vidbg`. These install into your
  `libraries/` directory when you require the module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Field Group, Media Library Form Element,
and the four JavaScript libraries listed above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ebt_core -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_core -y
```

Drupal enables Block Content, Media, Field Group, and Media Library Form Element
automatically as dependencies. Enabling EBT Core installs the shared
`field_ebt_settings` storage on `block_content` and creates the site-wide
`ebt_core.settings` configuration with its default breakpoints, widths, and the
`#0d77b5` background color.

## Submodules — enable only what you need

EBT Core ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **EBT Core Remove Helper** | `ebt_core_remove_helper` | Tools to bulk-remove EBT blocks and, once no EBT block types remain, the shared `field_ebt_settings` storage — useful for a clean uninstall. |
| **EBT Core Starterkit** | `ebt_core_starterkit` | A Drush generator (`drush generate ebt:module`) for scaffolding a brand-new EBT block-type module. |

For example:

```bash
drush en ebt_core_starterkit -y
```

Each submodule requires the base EBT Core module, which is already present once
you have installed it above.

## Next steps

On its own EBT Core does not add a placeable block — install one or more of the
individual EBT block-type modules (each requires this base module) to get actual
blocks. Then, if you want to adjust the site-wide brand colors, breakpoints, or
container widths, see [Configuration](../configuration/index.md).
