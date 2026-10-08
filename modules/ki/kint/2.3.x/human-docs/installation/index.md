# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- **PHP 8 or newer** (`php: >= 8`).
- The **Kint libraries**, pulled in automatically via Composer:
  - **`kint-php/kint`** (`^6.0.1`) — the dumper itself.
  - **`kint-php/kint-twig`** (`^6`) — Twig integration for `{{ d() }}` dumps.
- Optional: the **Devel** module (`drupal/devel`) — suggested, not required. When
  present, Kint can act as Devel's dumper.

Kint is a **development tool** — install it in your dev/staging environment, and
keep the **View kint output** permission off in production.

## Install with Composer

From the project root:

```bash
composer require drupal/kint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and pulls in the required `kint-php/kint` and
`kint-php/kint-twig` libraries. Installing via Composer is the supported way to
satisfy those libraries.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/kint -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kint -y
```

There are **no submodules**. After enabling, grant the **View kint output**
(`access kint dumps`) permission to the roles that should see dumps, and
optionally adjust the settings at **Configuration → Development → Kint** — see
[How to use it](../index.md#how-to-use-it).

```bash
drush role:perm:add developer 'access kint dumps'
```

## Verify it worked

Open **Configuration → Development → Kint** (`/admin/config/development/kint`). The
settings page renders a live demo dump of its own configuration — if you can see
that interactive dump, Kint is working and your role has the required permission.
