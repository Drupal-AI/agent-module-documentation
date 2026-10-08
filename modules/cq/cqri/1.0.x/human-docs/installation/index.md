# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Responsive Image** module (`responsive_image`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  CQRI. (Responsive Image ships with core but is not enabled by default.)

There are no third-party PHP or JavaScript library requirements; the container-query
script is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/cqri -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cqri -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cqri -y
```

Drupal will enable core Responsive Image at the same time if it isn't already on.

## Verify it worked

1. Go to **Configuration → Media → Responsive image styles** and confirm the
   **Container Queries Responsive Images** breakpoint group is available when creating
   a style.
2. Create a responsive image style using that breakpoint group, then on an image
   field's **Manage display** confirm the **Container queries responsive image**
   formatter is offered.
3. Apply it and view the content, ideally inside a Layout Builder section, to confirm
   the image responds to the container's size. See "How to use it" in the
   [overview](../index.md) for the full walkthrough.
