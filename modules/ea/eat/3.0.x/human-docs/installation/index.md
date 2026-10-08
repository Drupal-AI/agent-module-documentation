# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Views** module (`views`) — this is the only module dependency, and
  Drupal enables it automatically as a dependency when you turn on EAT. (Views is
  enabled on most sites already.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eat -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eat -y
```

## Verify it worked

Go to **Configuration → System → Entity Auto Term** (`/admin/config/system/eat`).
If the settings form loads, the module is installed. Nothing happens
automatically yet — you first need to map at least one node bundle to a
vocabulary, as described in [Configuration](../configuration/index.md). After
that, create a test node and confirm a matching taxonomy term appears in your
chosen vocabulary.
