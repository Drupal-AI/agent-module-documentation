# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Drush**, since the module runs after `drush sql:sanitize` and provides the
  `drush sp:fake` command.

There are no required module dependencies. The **Faker** library
(`fakerphp/faker`) is optional — install it only if you want locale‑rich
datasets.

## Install with Composer

From the project root:

```bash
composer require drupal/sanitize_placeholder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sanitize_placeholder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sanitize_placeholder -y
```

## Optional: country‑specific example strategies

A companion submodule, **`sanitize_placeholder_extra`**, ships country‑specific
example strategies you can use directly or study as a reference for building your
own:

```bash
drush en sanitize_placeholder_extra -y
```

## Optional: richer fake data with Faker

The module works with or without the Faker library. Without it, a lightweight
built‑in generator covers all the shipped strategies (first name, last name,
username, domain, institution, patterns and the extra examples), and the "Faker
locale" setting is ignored. With Faker you get a richer name/address vocabulary
and proper locale support (for example `fr_FR`, `de_DE`). To enable it:

```bash
composer require fakerphp/faker
```

## Verify it worked

Go to **Configuration → Development → Sanitize Placeholder**
(`/admin/config/development/sanitize-placeholder`) and confirm the settings page
loads. Add a rule or two, then either run `drush sql:sanitize` or `drush sp:fake`
and check the affected fields now hold realistic placeholder values. See
[Configuration](../configuration/index.md) for the details.
