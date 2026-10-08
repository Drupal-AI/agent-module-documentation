# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Several **core modules**, which Drupal enables as dependencies: Block content
  (`block_content`), Image (`image`), Media (`media`), Media Library
  (`media_library`), Views (`views`), Editor (`editor`), and Filter (`filter`).
- No third-party Composer or PHP library requirements.

## Install with Composer

The project is named `noahs` on drupal.org, so the Composer package is
`drupal/noahs`. From the project root:

```bash
composer require drupal/noahs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required core
modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/noahs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `noahs_page_builder` (it differs from the Composer
package name):

```bash
drush en noahs_page_builder -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Noahs Gallery** | `noahs_gallery` | A gallery configuration entity and a media widget for building image galleries within the builder. |

Enable it only if you need galleries:

```bash
drush en noahs_gallery -y
```

## Grant the permission

Noahs Page Builder is gated by a single permission, **Administer Noahs**
(`administer noahs_page_builder`). Grant it only to fully trusted roles — it
allows arbitrary HTML/CSS and unrestricted file upload. See
[Configuration](../configuration/index.md) for details.

## Verify it worked

Log in as a user with **Administer Noahs**, go to **Structure → Noahs**
(`/admin/structure/noahs`), and confirm the admin landing page loads. Then open a
node and look for the **Edit with Noahs** local task — clicking it should open the
drag-and-drop iframe editor.
