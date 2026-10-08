# Installation

## Requirements

- **Drupal 10.5 or 11.2** and up (`core_version_requirement: ^10.5 || ^11.2`).
- The **Pinto** module (`pinto`) — Pinto Entity depends on it, and Composer installs
  it (and the underlying Pinto PHP library) automatically.
- Pinto's PHP requirement applies (PHP 8.2+), inherited through the `pinto`
  dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/pinto_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Pinto module and
its library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pinto_entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pinto_entity -y
```

The base `pinto` module is enabled automatically as a dependency.

## Verify it worked

There is no UI to check. Confirm success in code: wire a Pinto component to an
entity's rendering, clear the cache (`drush cr`), then view that entity (on its
route, in a reference field, or a View) and confirm it renders through your
component. See the [official documentation](https://www.drupal.org/project/pinto_entity)
for a worked example.
