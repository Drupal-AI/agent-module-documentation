# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media Library** module (`media_library`) enabled — this is the only
  hard dependency, and Drupal enables it (and its own dependencies, Media and
  Views) automatically.

There are no third-party Composer or PHP library requirements. Two optional
integrations are suggested:

- **Diff** (`drupal/diff`) — adds a diff field builder so editors can compare
  original vs. overridden field values.
- **Inline Entity Form** (`drupal/inline_entity_form`) — used by tests and for
  inline media forms.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_media_modify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_library_media_modify -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_media_modify -y
```

There is no configuration form. Once enabled, add the **"Media with contextual
modifications"** field to a content type and choose the **"Media library extra"**
widget — see the [overview](../index.md#how-to-use-it).

## Optional: the entity_reference_entity_modify submodule

The bundled **entity_reference_entity_modify** submodule (experimental) extends
the same contextual-override mechanism to non-media entity references, adding an
autocomplete override widget:

```bash
drush en entity_reference_entity_modify -y
```

It requires the base module, which is already present once you have installed the
above. This submodule has its own documentation directory.
