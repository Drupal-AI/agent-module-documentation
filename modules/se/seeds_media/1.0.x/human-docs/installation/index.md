# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Core modules** it depends on and enables automatically: Field (`field`), File
  (`file`), Image (`image`), Media (`media`), Path (`path`), Text (`text`), User
  (`user`), Views (`views`), and Media Library (`media_library`).
- **Contrib module:** Media Library Edit (`media_library_edit`) — edit a media
  item from inside the library. Composer pulls this in for you.

There are no PHP or third-party library requirements. Because it ships a set of
opinionated media types, this is best adopted on a greenfield or Seeds-based site;
on an existing site, review the shipped types first so they do not clash with
media types you already have.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Media Library Edit
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_media -y
```

Enabling Seeds Media also enables its dependencies and installs the standard media
types.

## Verify it worked

Go to **Content → Media → Add media** — you should see the shipped media types
(such as image, document, and remote video). Opening the media library while
adding media to a field should let you edit an item in place, courtesy of Media
Library Edit. Then review the permissions and settings under
[Configuration](../configuration/index.md) before going live.
