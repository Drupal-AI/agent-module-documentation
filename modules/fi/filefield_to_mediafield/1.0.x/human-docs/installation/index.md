# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **File** (`file`) and **Media** (`media`) modules — both are declared
  dependencies and Drupal enables them for you.
- **Drush**, since the module is driven entirely from the command line.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filefield_to_mediafield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filefield_to_mediafield -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filefield_to_mediafield -y
```

## Prepare the target media field

Before running the copy, add the **media reference field** you want to fill to the
entity bundle, and make sure it is **empty** — the command appends to it, so it
should not already contain values. Then **take a database backup**; the command
mutates every matched entity.

## The command, argument by argument

```bash
drush filefield-to-media:copy <file_field> <media_field> <media_bundle> <media_entity_file_field> <entity_type> [bundle] [--no-reuse]
```

| Position | Argument | Default | Meaning |
|----------|----------|---------|---------|
| 1 | `file_field_name` | `field_image` | The source file/image field to read from. |
| 2 | `media_field_name` | `field_image_media` | The target media‑reference field to fill. |
| 3 | `media_bundle` | `image` | The media type to create. `image` maps alt/title/width/height; any other bundle maps display/description. |
| 4 | `media_entity_file_field_name` | `field_media_image` | The file/image field *on the media entity*. |
| 5 | `entity_type` | `node` | The entity type to iterate over. |
| 6 | `bundle` | *(optional)* | Restrict to one bundle; omit to process all bundles of the type. |

The single option, `--no-reuse`, disables the default de‑duplication (which hashes
existing media files with `sha1_file` and reuses a match). Use it when the reuse
hashes cause trouble, when the media field configuration is non‑default, or when
you deliberately need duplicate media with different alt/title text.

Example — copy `field_image` on Article nodes into image media referenced from
`field_image_media`:

```bash
drush fftm field_image field_image_media image field_media_image node article
```

## Verify it worked

Open a few of the affected entities and confirm the media field is now populated
and rendering. Review the `filefield_to_mediafield` log channel for any per‑entity
errors. Once you are happy the media is correct, you can safely delete the legacy
file field from the bundle.
