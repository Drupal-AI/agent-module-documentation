# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Ban** module (`ban`) enabled — this is the only dependency, and it is
  what actually stores and enforces the IP bans. Drupal will enable it as a
  dependency when you turn on Perimeter.

There are no third-party PHP library or Composer requirements. Perimeter also
integrates with the contrib **Honeypot** module if it is present (banning IPs that
fail a honeypot check), but it does not depend on it.

## Install with Composer

From the project root:

```bash
composer require drupal/perimeter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/perimeter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en perimeter -y
```

This also enables core Ban if it is not already on. The module ships no
submodules. As soon as it is enabled it starts banning IPs that hit its built-in
list of suspicious 404 patterns — see [Configuration](../configuration/index.md)
to tune the patterns, whitelist, and thresholds, and to hand out the related
permissions.

> **Tip:** because bans are stored by core Ban, you (or an administrator) can
> always undo a mistaken ban from **Configuration → People → IP address bans**
> (`/admin/config/people/ban`). It is worth whitelisting your own office/CDN IPs
> before a busy launch.
