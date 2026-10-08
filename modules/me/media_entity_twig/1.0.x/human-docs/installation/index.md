# Installation

## Requirements

- **Drupal 10.3 or newer** (`core_version_requirement: >=10.3`).
- Drupal core's **Image** (`image`), **Media** (`media`), **Media Library**
  (`media_library`), and **Path** (`path`) modules.
- The contrib **Twig Field** module (`twig_field`), which provides the field type
  that stores the Twig content. Composer pulls it in automatically with the
  command below.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Twig Field and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_twig -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_twig -y
```

The core dependencies and the Twig Field module are enabled automatically if they
are not already on.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`) and confirm a new
**Twig** media type is listed, with a default Twig field already present at
`/admin/structure/media/manage/twig/fields`. Before letting anyone use it, review
the Twig media permissions under **People → Permissions** and grant them only to
trusted builders — see the [main guide](../index.md).
