# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).

There are no module dependencies and no third‑party PHP libraries. It is most
useful on a **decoupled / headless** site whose front end drives login and logout
over HTTP.

## Install with Composer

From the project root:

```bash
composer require drupal/logout_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/logout_token -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logout_token -y
```

That's all — there is no configuration to do.

## Verify it worked

While authenticated (in a browser session or with a session cookie from an API
login), make a **GET** request to `/session/logout/token`. You should receive the
logout token for the current session. An anonymous request should not return a
usable token.
