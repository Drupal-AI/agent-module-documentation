# Installation

## Requirements

AT-LS needs **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`)
and several other modules, which Composer resolves for you:

- **Advanced Queue** (`advancedqueue`) — runs the translation jobs in the
  background.
- Core **Basic Auth** (`basic_auth`) — used for the authenticated API calls.
- Core **Content Translation** (`content_translation`) — the multilingual
  foundation.
- **Key** (`key`) — stores the AT-LS credentials securely (env‑backed).
- **State Machine** (`state_machine`) — drives the request/string workflow states.

The module also builds on core Views and the contrib Entity / JSON Field modules,
which come in as transitive dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/at_ls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Advanced Queue,
Key, State Machine, and the other dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/at_ls -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en at_ls -y
```

The required modules above are enabled automatically as dependencies.

## Next step

Before you can send anything to AT-LS you must store your API credentials and
enter the connection details — see [Configuration](../configuration/index.md).
