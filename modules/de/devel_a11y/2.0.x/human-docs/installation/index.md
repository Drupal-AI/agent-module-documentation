# Installation

## Requirements

- **Drupal 11.2 or newer, or Drupal 12** (`core_version_requirement: ^11.2 || ^12`).
  This is a recent-core module, so it will not install on Drupal 10.
- The **Devel** module (`devel`), which is a hard dependency. Drupal will pull it
  in as a dependency, but you can also require it explicitly with Composer.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_a11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Devel — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_a11y -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Devel and Devel Accessibility together:

```bash
drush en devel devel_a11y -y
```

All three debugging aids are switched **on by default** as soon as the module is
enabled, so you can start using them immediately — see
[Configuration](../configuration/index.md) to turn individual aids off.

There are no submodules.

> **Keep it off production.** The aids attach on every page for any user who can
> reach them (via Devel's *Access developer information* permission), so treat this
> exactly as you treat Devel — a local and staging tool only.
