# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.2 or higher**.
- Core's **Layout Builder** module (`layout_builder`), which is the module's
  dependency and is enabled automatically.
- The **Pinto** object system at the code level. Pinto Block builds on Pinto's theme
  objects; install [`pinto`](https://www.drupal.org/project/pinto) alongside it.
  Optionally, the BCA or Hux modules make declaring bundle classes more ergonomic,
  but they are not required — core's `hook_entity_bundle_info_alter()` works too.

## Install with Composer

From the project root:

```bash
composer require drupal/pinto_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Pinto library) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pinto_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pinto_block -y
```

Layout Builder is enabled automatically as a dependency if it is not already on.

## Verify it worked

Pinto Block has no UI, so verification is in code. Define a bundle class, a Pinto
object, and the `#[PintoBlock]` link (see the [How to use it](../index.md#how-to-use-it)
steps), clear the cache with `drush cr`, then place that block through Layout Builder
and confirm it renders through your object. If the block renders with the default
build instead, re-check that the attribute is on the bundle class and that the cache
has been cleared.
