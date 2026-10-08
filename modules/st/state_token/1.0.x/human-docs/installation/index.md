# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The module provides tokens for use with the **Token** module
  (`drupal/token`). Install Token to browse and use the tokens conveniently.
- This is a beta release; test before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/state_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/state_token -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

If you don't already have the Token module, install it too so you get the token
browser:

```bash
composer require drupal/token -W
```

## Enable the module

```bash
drush en state_token -y
```

There is no configuration form — enabling the module makes its state/request
tokens available.

## Verify it worked

Open any place that offers a token browser (for example a field or a text setting
that supports tokens) and confirm the module's state/request tokens appear and
resolve to the expected request values.
