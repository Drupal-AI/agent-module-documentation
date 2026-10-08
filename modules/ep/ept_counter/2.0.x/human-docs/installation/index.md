# Installation

## Requirements

EPT Counter is a small module that builds on two others:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base that supplies the per-instance
  design options (spacing, background, container width) used by every EPT
  paragraph type.
- **Paragraphs** (`paragraphs`) — the contrib module that provides the paragraph
  mechanism itself.

Composer pulls both dependencies in automatically. There are no PHP extension or
third-party library requirements to install by hand — the countUp.js behaviour
ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ept_core`,
`paragraphs`, and any shared dependencies they need.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ept_counter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Pin the EPT family together.** The EPT component modules do not each declare a
> version constraint on `ept_core`, and the shared widget base class has changed
> between releases. If you use several EPT modules, require and update them as a
> set so their versions stay in step with `ept_core`.

## Enable the module

```bash
drush en ept_counter -y
```

Enabling the module also enables `ept_core` and `paragraphs` if they aren't
already on. Drupal then imports the **Counter** paragraph type from the module's
configuration.

## Verify it worked

1. Visit **Structure → Paragraphs types**
   (`/admin/structure/paragraphs_type`) and confirm a **Counter** type is listed.
2. On a content type that has a Paragraphs field, edit a piece of content, add a
   **Counter** paragraph, enter a few numbers with labels, and save.
3. View the page — the numbers should count up as they scroll into view.

For how to place and style the counter, see
[How to use it](../index.md#how-to-use-it) in the overview.
