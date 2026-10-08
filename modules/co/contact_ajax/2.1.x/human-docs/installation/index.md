# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`) enabled — this is the only dependency, and
  Drupal enables it automatically. You'll configure the module on your existing
  contact forms.

There are no third‑party Composer or PHP library requirements.

**Suggested companion:** [Contact Storage](https://www.drupal.org/project/contact_storage)
(`drupal/contact_storage`) stores submitted contact messages in the database, so you
keep a record of submissions while still using the AJAX experience. It's optional.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_ajax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_ajax -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_ajax -y
```

There are no submodules and no permissions to grant. After enabling, edit any
contact form and you'll find a new **Contact ajax** section — see
[Configuration](../configuration/index.md).
