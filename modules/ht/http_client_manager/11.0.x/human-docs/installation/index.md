# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- **Drush 12 or newer** (`drush/drush >=12.0.0`) — required, and also what powers
  the service generator.
- Two third-party PHP libraries, which Composer installs automatically:
  - `guzzlehttp/guzzle-services` (`^1`) — the Guzzle service-description engine.
  - `fatal-error/guzzle-description-loader` (`^3.1.1`) — loads descriptions from
    JSON/YAML/PHP files.

Because of those libraries you should always install this module **with Composer**
rather than by downloading a zip — Composer is what pulls the dependencies in.

## Install with Composer

From the project root:

```bash
composer require drupal/http_client_manager -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in `guzzlehttp/guzzle-services` and `fatal-error/guzzle-description-loader` and
reconcile any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/http_client_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_client_manager -y
```

## Optional: the example submodule

The project ships one submodule, **HTTP Client Manager Example**
(`http_client_manager_example`), which describes the public JSONPlaceholder API
(operations like `FindPosts`, `FindPost`, `CreatePost`) so you have a working,
end-to-end example to inspect and copy from. Enable it if you want to see a real
service description and try the preview UI against a live API:

```bash
drush en http_client_manager_example -y
```

It's purely a learning aid — leave it disabled on production sites.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → HTTP Client
Manager** (`/admin/config/services/http-client-manager`). If you enabled the
example submodule, you should see the example service listed and be able to
preview its commands.
