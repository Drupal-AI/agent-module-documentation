# Installation

## Requirements

Courier needs:

- **Drupal 9.5 or newer** (`core_version_requirement: >=9.5`).
- **PHP 7.4 or newer** (`php: >=7.4`).
- Core's **Text** module (`text`), enabled automatically as a dependency.
- The contrib **Dynamic Entity Reference** module (`drupal/dynamic_entity_reference`,
  `^1 || ^2 || ^3 || ^4`), which template‑collection ownership relies on. Composer
  pulls it in automatically.

Optional: the contrib **Token** module improves the token picker on message edit
forms (not required).

## Install with Composer

From the project root:

```bash
composer require drupal/courier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `drupal/dynamic_entity_reference`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/courier -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en courier -y
```

Drupal enables the required **Text** and **Dynamic Entity Reference** modules at the
same time.

## Submodules

Courier ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Courier System** | `courier_system` | Replaces Drupal's core account/user emails with Courier‑managed templates. |
| **Courier Message Composer** | `courier_message_composer` | A one‑off message composer. **Not compatible with Drupal 11** — its info file declares support only up to Drupal 10, so it cannot be enabled on a Drupal 11 site. |

To enable Courier System:

```bash
drush en courier_system -y
```

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant the restricted
**Administer courier** permission to trusted administrators so they can reach the
settings and maintenance forms. See [Configuration](../configuration/index.md) for
what those forms control.
