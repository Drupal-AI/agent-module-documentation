# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Media** module (`media`).
- Several contrib modules, all pulled in by Composer:
  - **Paragraphs** (`drupal/paragraphs` `^1.0`) — the paragraph system EPT builds on.
  - **Field Group** (`drupal/field_group` `^3.0 || ^4.0`) — groups the design-option
    fields into tidy sections.
  - **Media Library Form Element** (`drupal/media_library_form_element` `^2.0`) — for
    choosing background media.
- Four JavaScript libraries, also pulled in by Composer, that power EPT's visual
  effects: a color picker (`levmyshkin/jquery-colorpicker`), a YouTube player
  (`levmyshkin/jquery-mb-ytplayer`), parallax (`levmyshkin/parallaxjs`), and video
  backgrounds (`levmyshkin/vidbg`).

Because of the JavaScript libraries, installing with Composer (which resolves them
all for you) is strongly recommended over a manual download.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs, Field
Group, Media Library Form Element, and the four JavaScript libraries, updating shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_core -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_core -y
```

This also enables the Media, Paragraphs, Field Group, and Media Library Form Element
modules if they aren't already on. Enabling EPT Core installs the shared field
storages (`field_ept_settings`, `field_ept_text`, `field_ept_title`) and the EPT
Settings field type.

## Next steps

EPT Core adds no usable paragraph type by itself — it's the base layer. To actually
build pages, install one or more `ept_*` paragraph modules on top of it, or add the
EPT Settings field to your own paragraph type. See
[How to use it](../index.md#how-to-use-it) in the main guide, and set your site-wide
defaults at **Configuration → Content authoring → EPT Core**.

## Optional submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **EPT Core Starterkit** | `ept_core_starterkit` | A Drush code generator that scaffolds a brand-new EPT paragraph module. For developers only. |

Enable it only if you plan to build your own EPT paragraph modules:

```bash
drush en ept_core_starterkit -y
```
