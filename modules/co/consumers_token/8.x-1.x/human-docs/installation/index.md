# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Consumers** module (`consumers`) — this is the only dependency, and it is
  what defines the consumers whose names the token resolves to.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/consumers_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Consumers
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/consumers_token -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consumers_token -y
```

Drupal will enable the Consumers module too if it isn't already on.

## Verify it worked

Once enabled, the `[consumers:current-name]` token is available anywhere Drupal
tokens are accepted. Add it to a token-aware field (for example a Metatag
pattern), then request that content through the API as a given Consumer — the
token should resolve to that Consumer's name.
