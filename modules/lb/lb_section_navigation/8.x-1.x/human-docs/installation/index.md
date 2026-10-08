# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** enabled (the block is placed within a Layout Builder
  section).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_section_navigation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_section_navigation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_section_navigation -y
```

## Verify it worked

Edit a Layout Builder layout and confirm the section navigation block appears in
the "Add block" list. Place it inside a section that has several components, save,
and view the page — you should see a list of anchor links jumping to each
component in that section.
