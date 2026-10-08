# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **A working Shibboleth Service Provider (SP)** in front of Drupal — for example
  Apache with `mod_shib`. This is the real prerequisite. The SP must:
  - authenticate users and expose their attributes to the web server (as
    `$_SERVER` / environment variables such as `eppn`, `Shib-Session-ID`, and,
    for Grouper, `isMemberOf`); and
  - protect the `/basicshib/login` path so that only SP-authenticated requests
    ever reach it.

BasicShib itself has **no Drupal module dependencies** — it only requires Drupal
core. Everything else is handled by the SP at the web-server layer.

## Install with Composer

From the project root:

```bash
composer require drupal/basicshib -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basicshib -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en basicshib -y
```

## After enabling

Grant the BasicShib admin permissions (all marked *restrict access* — trusted
operators only): **Administer basicshib**, and — once you turn Grouper on —
**Administer authorization** and **Administer policies**. Then work through the
[Configuration](../configuration/index.md) page to set your attribute map and
login handlers. Nothing works until the SP in front of Drupal is authenticating
users and the attribute names in BasicShib match the server variables your SP
publishes.
