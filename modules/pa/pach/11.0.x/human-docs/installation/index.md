# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 | ^12`).
- No other module dependencies.

> **Version note:** pick the pACH branch that matches your Drupal version. The
> `11.0.x` branch documented here targets Drupal **11 and 12**. For Drupal
> **10.3+/11** use the older `10.3.x` branch instead — the branches track the
> Drupal core major, so install the one that matches your core version.

## Install with Composer

From the project root:

```bash
composer require drupal/pach -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pach -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pach -y
```

## Enable the examples submodule (recommended for developers)

pACH ships no access plugins of its own — it is infrastructure. The
`pach_examples` submodule contains reference block and node access plugins that
are the fastest way to learn how to write your own:

```bash
drush en pach_examples -y
```

## Verify it worked

Enabling pACH decorates core's entity type manager transparently; there is
nothing visible in the UI to check. To confirm it is doing its job, enable
`pach_examples` (or your own access plugin) and exercise the access rules it
defines — for example, confirm the example node rule alters node access as its
code describes. Remember to clear caches (`drush cr`) after adding a new plugin so
it is discovered.
