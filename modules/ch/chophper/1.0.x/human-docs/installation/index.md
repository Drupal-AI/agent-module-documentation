# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Text** module (`text`) enabled — Drupal enables it automatically as a
  dependency.
- The **`code-atlantic/chophper`** PHP library, which Composer installs for you
  when you require the module (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/chophper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Because you're installing via Composer, the required
`code-atlantic/chophper` PHP library is pulled in automatically — there's no
separate library download step.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chophper -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chophper -y
```

## Verify it worked

Open a bundle's **Manage display** tab. For a text field such as **Body**, the
**Format** dropdown should now include **Trimmed (Chophper)** and **Summary or
trimmed (Chophper)**. Choosing one and setting a trim length will truncate the
field on output while keeping its HTML valid.
