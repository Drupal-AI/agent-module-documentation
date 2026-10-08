# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **ProseMirror** module (`prosemirror`) — this module extends it and depends on
  it. Composer installs it automatically as a dependency.
- The **FontAwesome** library available on your front‑end theme, and a text format
  that allows `<i>` with `class`, for icons to display to visitors (see the overview's
  "How to use it").

## Install with Composer

From the project root:

```bash
composer require drupal/prosemirror_fontawesome_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the ProseMirror
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prosemirror_fontawesome_icons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prosemirror_fontawesome_icons -y
```

This enables the base ProseMirror module too, if it is not already on.

## Verify it worked

Follow the "How to use it" steps on the [overview page](../index.md): add a ProseMirror
element with the machine name `icon`, then open a ProseMirror editor. The **Icon**
button should appear in the toolbar's Embed drop‑down, and clicking it should open the
searchable icon picker.
