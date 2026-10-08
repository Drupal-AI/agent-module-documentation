# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's node-access system (part of core) — ACL registers itself as a node-access
  module.
- No third-party libraries and no other contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/acl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In practice you rarely install ACL by hand — it usually
arrives as a dependency of another module that builds on it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acl -y
```

> **Heads up:** because ACL is a node-access module, enabling it triggers a
> **node-access permissions rebuild**. This is expected. On a large site the
> rebuild can take a little while.

There are no submodules.

## Verify it worked

ACL has no UI to check. Once enabled, it simply provides its API for other modules
to use. If you installed it as a dependency, configure the module that requires it
— that module supplies the actual interface. Developers can confirm the `acl`,
`acl_user`, and `acl_node` database tables now exist.
