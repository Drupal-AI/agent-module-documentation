# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`) — always present in a Drupal install.
- **PHP 7.3 or newer**.
- Optional: the **REST UI** module, only if you want to expose the password
  recommendations as a REST resource.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pug -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pug -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pug -y
```

## Turn on the core prerequisite

Pug's guidance appears next to Drupal's password strength indicator, so enable
that first: go to **Configuration → People → Account settings**
(`/admin/config/people/accounts`) and check **Enable password strength
indicator**. Then customise Pug's recommendation text — see the
[overview](../index.md) for the walkthrough.

## Verify it worked

Open a user **add** or **edit** form and start typing a password. You should see
password recommendations under the *Confirm password* field reflecting the text
Pug provides. Once you've edited that text in Pug's settings, confirm your custom
wording appears here.
