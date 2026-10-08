# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** and **Views** modules (`user`, `views`) — Views is a hard
  dependency and Drupal enables it for you.
- **Display Suite** is *recommended* (not required) if you want the virtual field
  that automatically truncates paywalled content.
- A **1Pass account** with API credentials (a publishable key and a secret key)
  from [1pass.me](https://1pass.me/).

> **Maintenance status:** this project is *minimally maintained* (maintenance
> fixes only). It works, but do not expect active feature development.

## Install with Composer

From the project root:

```bash
composer require drupal/onepass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/onepass -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en onepass -y
```

If you want the automatic content‑truncation field, also enable Display Suite:

```bash
drush en ds -y
```

## Verify it worked

Confirm the module is enabled on the **Extend** page, then open
**Configuration → Content authoring → OnePass**
(`/admin/config/content/onepass`) and check the settings form loads. You are ready
to enter your 1Pass keys — see [Configuration](../configuration/index.md).
