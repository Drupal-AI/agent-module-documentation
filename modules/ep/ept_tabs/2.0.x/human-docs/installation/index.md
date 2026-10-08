# Installation

## Requirements

EPT Tabs has more dependencies than most EPT components, because a tab can hold a
View or a block:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base supplying per-instance design
  options (spacing, background, container width).
- **Paragraphs** (`paragraphs`) — the paragraph mechanism.
- Core's **Views** (`views`).
- **jQuery UI Tabs** (`jquery_ui_tabs`) — the tabs behaviour. Note that jQuery UI
  was removed from Drupal core and this contrib module is maintained on a
  best-effort basis.
- **Block field** (`block_field`) — lets a tab hold a placed block.
- **Views Reference** (`viewsreference`) — lets a tab hold an embedded View.

There are no PHP extension requirements to install by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, `jquery_ui_tabs`, `block_field`, `viewsreference`, and any shared
dependencies they need.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_tabs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together.** The EPT component modules do not each declare a
> version constraint on `ept_core`, and the shared widget base class has changed
> between releases. If you use several EPT modules, require and update them as a
> set so their versions stay in step with `ept_core`.

## Enable the module

```bash
drush en ept_tabs -y
```

Enabling the module also enables `ept_core`, `paragraphs`, `views`,
`jquery_ui_tabs`, `block_field`, and `viewsreference` if they aren't already on,
then imports the **Tabs** paragraph type.

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm a **Tabs** type is listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add a
   **Tabs** paragraph, add two or three tabs, and save.
3. View the page — the tab set should render and switch between panels when you
   click each tab.

For how to place, fill, and style the tabs, see
[How to use it](../index.md#how-to-use-it) in the overview.
