# Installation

## Requirements

EPT Sticky Menu builds on two other modules:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **EPT Core** (`ept_core`) — the shared base supplying per-instance design
  options (spacing, background, container width).
- **Paragraphs** (`paragraphs`) — the paragraph mechanism.

There are no PHP extension or third-party library requirements to install by
hand.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_sticky_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, and any shared dependencies they need.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_sticky_menu -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together.** The EPT component modules do not each declare a
> version constraint on `ept_core`, and the shared widget base class has changed
> between releases. If you use several EPT modules, require and update them as a
> set so their versions stay in step with `ept_core`.

## Enable the module

```bash
drush en ept_sticky_menu -y
```

Enabling the module also enables `ept_core` and `paragraphs` if they aren't
already on, then imports the sticky-menu paragraph type.

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm the sticky-menu type is
   listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add the
   sticky-menu paragraph, add a couple of links, and save.
3. View the page and scroll — the menu should stick to the viewport.

For how to place and style the menu, see
[How to use it](../index.md#how-to-use-it) in the overview.
