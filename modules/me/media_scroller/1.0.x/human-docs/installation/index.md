# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Image** module (`image`).
- The [Slick](https://www.drupal.org/project/slick) module (`slick`) and its Slick
  carousel JavaScript library, which supplies the scroller behavior. Follow Slick's
  own installation notes to place the library where Drupal expects it.

## Install with Composer

From the project root:

```bash
composer require drupal/media_scroller -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Slick module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_scroller -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_scroller -y
```

Drupal will enable **Slick** and **Image** at the same time if they are not already
on.

## Verify it worked

Go to a content type that has an image or media-image field, open its **Manage
display** tab, and confirm **Media Scroller** appears in the format dropdown for
that field. Selecting it and adding a few images should render a horizontal scroller
with thumbnail navigation on the entity's display. The rest of the setup is in
[How to use it](../index.md#how-to-use-it).
