# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Token** module (`token`) — Character Generator depends on it to expose the
  `[charactergen:random]` token. Composer installs it automatically.
- Commonly paired with the **Automatic Entity Labels** module (part of the Auto
  Entity Label project) so the token can build entity labels, though that is your
  choice of where to use the token.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/charactergen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Token
dependency and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charactergen -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charactergen -y
```

Drupal enables the Token module at the same time if it isn't already on.

## Verify it worked

No configuration is needed. To confirm it's working, use the token in a label
pattern (for example in an Automatic Entity Labels setting), or check the token
browser where tokens are listed — you should find `[charactergen:random]`
available. Creating a new entity that uses it should produce a random
10‑character code as its label.
