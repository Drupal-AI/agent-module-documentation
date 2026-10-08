# Installation

## Requirements

- **Drupal 10.4+, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- Core's **Views** module (`views`) — enabled by default in a standard install,
  and pulled in as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_timeline -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simple_timeline -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_timeline -y
```

There are no submodules. Once enabled, **Simple Timeline** is available as a
Format choice in the Views UI — see the
[main guide](../index.md#how-to-use-it) for how to apply it.

## Verify it worked

Edit any view and open its **Format** setting; **Simple Timeline** should appear
in the list of styles. Select it, configure the item and marker positions, and
save — the view's rows should render as a vertical timeline.
