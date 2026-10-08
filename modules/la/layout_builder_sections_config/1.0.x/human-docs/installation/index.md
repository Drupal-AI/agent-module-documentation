# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the module's
  only dependency, and Drupal enables it automatically. (Layout Builder in turn needs
  core's Layout Discovery module.)

There are no third-party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_sections_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/layout_builder_sections_config -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_sections_config -y
```

If Layout Builder is not already enabled, Drupal enables it as a dependency.

Once enabled, the extra fields appear the next time you configure a Layout Builder
section, and the global settings page becomes available at
**Configuration → Content authoring → Layout Builder Sections Config**. See
[Configuration](../configuration/index.md) for both.

## A note on theme templates

The module overrides the core layout templates and ships CSS so its section titles,
ids, and classes render. If your own theme overrides the same layout templates (for
example `layout--twocol-section.html.twig`), the module's output can be lost — you may
need to port its title block into your theme's templates. This is covered in the
[Configuration](../configuration/index.md#theme-templates-important) guide.
