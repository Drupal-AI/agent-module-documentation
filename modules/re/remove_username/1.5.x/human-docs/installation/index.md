# Installation

## Requirements

Remove Username field is very lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **User** module, which is always present on a Drupal site.

There are no third‑party Composer packages, PHP libraries or other module
dependencies. If you run Drupal Commerce, the module will also adjust the
Commerce checkout flow automatically — but Commerce is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_username -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/remove_username -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_username -y
```

Enabling the module triggers a one‑time backfill: it loads every existing
(non‑anonymous) account and copies its email into its username. Accounts with no
email are skipped and logged. From then on, the email‑as‑username rule applies to
every save.

There is **no configuration** — no settings form, no permissions, no submodules.
Once enabled, the module is fully active.

## Verify it worked

Visit `/user/register` as an anonymous visitor: the registration form should show
an **Email address** field (required) and **no** Username field. On the login
form (`/user/login`), the first field should be labelled **Email address**.
