# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **presentation module** for your framework — one of `pdb_react`, `pdb_vue`,
  `pdb_ember`, or `pdb_default` — installed separately. PDB itself renders nothing without
  one.
- Your own **component code** (a directory with a `type: pdb` info file plus its JS/CSS).

PDB has no PHP-library or contrib-module dependencies of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/pdb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdb -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdb -y
```

## Add a presentation module

PDB provides no concrete block on its own. Install and enable the presentation module for
the framework you are using, for example React:

```bash
composer require drupal/pdb_react -W
drush en pdb_react -y
```

Each presentation module supplies both the concrete block class and the framework runtime
library that your components depend on. Repeat for any other framework you need — a single
site can mix, say, React and Vue components.

After that, add your components and clear caches (`drush cr`) so PDB discovers them. See
[Configuration](../configuration/index.md) for how discovery works and how to configure a
component.
