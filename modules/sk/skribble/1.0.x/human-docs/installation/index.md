# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Skribble account** with an API user and API key — the module cannot talk to
  the service without them (you add these in [Configuration](../configuration/index.md)).
- A configured **private file system**, since signed PDFs are stored in
  `private://skribble/`.

The module itself has no dependent contrib modules and no additional PHP or
third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/skribble -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/skribble -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en skribble -y
```

## Next steps

The module does nothing until it is configured. Head to
[Configuration](../configuration/index.md) to enter your Skribble user and API
key and choose how documents are delivered to Skribble.
