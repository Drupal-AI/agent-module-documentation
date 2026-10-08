# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **`ajgl/breakpoint-twig-extension`** library (`^0.3.4`) — Composer pulls it
  in automatically when you require the module. (The module blocks installation
  if this library is missing.)
- A working **Xdebug** installation with step debugging enabled, and your IDE
  listening for connections. This is what actually makes `breakpoint()` stop;
  without Xdebug the function does nothing observable.

There are no dependent Drupal modules.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_xdebug -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared library
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/twig_xdebug -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.
> DDEV can enable and configure Xdebug for you with `ddev xdebug on`.

## Enable the module

```bash
drush en twig_xdebug -y
```

That is the entire setup — there is nothing to configure. Add
`{{ breakpoint() }}` to a template (see the main guide) and trigger the page with
your debugger listening.

## Development only

Enable this only on local/development sites. It exposes a debugging primitive and
depends on Xdebug being active, so it should never be enabled on production. When
you're finished, disable it with `drush pmu twig_xdebug -y`.
