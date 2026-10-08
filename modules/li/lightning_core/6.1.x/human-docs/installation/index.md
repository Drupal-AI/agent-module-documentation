# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core modules **Node**, **Path**, **Text**, and **User** (`node`, `path`, `text`,
  `user`) — enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements. Some **submodules** pull
in extra contrib modules (see below); the base module does not.

## Install with Composer

From the project root:

```bash
composer require drupal/lightning_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lightning_core -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lightning_core -y
```

Once enabled you get the base APIs and conveniences — role/display‑mode descriptions,
the `_is_administrator` route check, the *Long (12‑hour)* date format, and the Lightning
landing page — with nothing further to configure.

## Submodules — enable only what you need

Lightning Core ships four optional submodules that build turnkey features on top of it.
Enable them individually with `drush en`. Some need an extra contrib module (shown), and
Composer will fetch it with the `-W` command above when required:

| Submodule | Machine name | What it adds | Needs |
|-----------|--------------|--------------|-------|
| **Lightning Roles** | `lightning_roles` | Automatically creates creator/reviewer content roles per content type. | — |
| **Basic Page** | `lightning_page` | A ready‑made *Basic page* content type. | Metatag suggested |
| **Lightning Search** | `lightning_search` | A simple database‑backed search page. | Search API |
| **Contact Form** | `lightning_contact_form` | A site‑wide contact form with sensible defaults. | Contact Storage |

For example, to add the automatic content roles:

```bash
drush en lightning_roles -y
```

Each submodule requires the base Lightning Core module, which is already present once
you have installed it above.

## A note on Drush

Lightning Core adds two Drush conveniences (not standalone commands): a `base-profile`
field on `drush core:status`, and an automatic plugin‑cache clear before
`drush updatedb` runs, which avoids stale‑cache errors during database updates.
