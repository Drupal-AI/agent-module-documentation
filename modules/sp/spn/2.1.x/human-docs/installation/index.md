# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9||^10||^11`).
- Core **Link**, **Views** and **Node** modules (plus Field, Path, User and
  Block), all part of a standard Drupal install.
- A properly configured **private file system** if you want to use the CSV export
  of signatures (check it at **Configuration → Media → File system**).
- No third‑party PHP libraries. (CAPTCHA / reCAPTCHA were dependencies in older
  releases but were removed in 2.0 — you can still add spam protection yourself.)

## Install with Composer

From the project root:

```bash
composer require drupal/spn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spn -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spn -y
```

Enabling the module does several things for you automatically: it creates a
**Petition** content type with its predefined fields, adds the **Petition signing
form** and **Petition results** blocks, and adds the *Petition Signatures* and
*Petition Users* tables to the database.

## Verify it worked

- Go to **Structure → Content types** and confirm a **Petition** type now exists.
- Go to **Structure → Block layout** and confirm the two petition blocks are
  available to place.

Next, set up your default notification emails and place the blocks — see
[Configuration](../configuration/index.md).
