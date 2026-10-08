# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer**.
- Core's **Path alias** module (`path_alias`) — enabled automatically as a
  dependency.
- *Optional:* the **Redirect** module (`drupal/redirect`) if you want the
  endpoint to follow editorial redirects and report the redirect chain.
- *Optional:* core's **JSON:API** module if you want the response to include the
  JSON:API resource link for each resolved entity.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_router -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/decoupled_router -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_router -y
```

That's all. There is no configuration form — the `/router/translate-path`
endpoint is available immediately. If you want redirect-following or JSON:API
links in the response, enable those optional modules too:

```bash
drush en redirect jsonapi -y
```
