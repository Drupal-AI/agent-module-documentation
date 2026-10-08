# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The default **Past DB** backend stores events as entities — install the base
  module together with a backend submodule so events actually have somewhere to go.
- **Views** is recommended (not required) — it lets you list and filter logged
  events in the reports section of your site.

## Install with Composer

From the project root:

```bash
composer require drupal/past -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/past -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base framework and the database backend together — the base module on
its own has no storage:

```bash
drush en past past_db -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Past DB** | `past_db` | The default database/entity storage backend, with Views and Drush integration and expiration of old entries. This is the backend most sites want — enable it unless you are providing your own backend. |
| **Past Form** | `past_form` | Adds form‑related logging on top of the framework. |

Past also ships a test backend used for development, which displays events as debug
output; you would not normally enable it in production.

## Verify it worked

With `past` and `past_db` enabled, log a test event from custom code (or trigger an
action your code logs), then open the Past event listing in the admin area. You
should see the event, and — if you drill in — its attached arguments stored as
readable, individually listed data.
