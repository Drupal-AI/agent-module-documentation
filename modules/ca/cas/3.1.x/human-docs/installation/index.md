# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **External Authentication** module (`drupal/externalauth` `~2.0.6`) — CAS
  uses it to link and provision Drupal accounts. Composer pulls it in for you.
- The **js_cookie** library module (`drupal/js_cookie` `^1.0 || ^2.0`), also
  installed automatically by Composer.
- PHP's **DOM extension** (`ext-dom`), used to parse the CAS server's XML ticket
  responses. This is present in almost every PHP install.

## Install with Composer

From the project root:

```bash
composer require drupal/cas -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `externalauth` and `js_cookie`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cas -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cas -y
```

Drupal will enable the `externalauth` dependency at the same time. CAS ships **no
submodules** — the single module provides everything, including a Drush command
for linking accounts.

## Next steps

Nothing works until you point CAS at your identity provider. Head to
**Configuration → People → CAS** and fill in the server connection — see
[Configuration](../configuration/index.md).
