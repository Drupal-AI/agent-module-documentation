# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The PHP **LDAP extension** must be available on the web server — the module talks
  to your directory through PHP's built‑in `ldap_*` functions. (This isn't a
  Composer dependency, but LDAP login can't work without it.)
- Network access from the web server to your **LDAP / Active Directory** server
  (typically port 389, or 636 for LDAPS).

There are no additional Drupal module dependencies and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ldap_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ldap_auth -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. Note that the DDEV/container
> host must be able to reach your LDAP server on the network.

## Enable the module

```bash
drush en ldap_auth -y
```

At install the module seeds a few defaults (for example server port `389` and a
default username attribute of `samaccountName`). There are no submodules.

## After enabling — configure

The module does nothing until you configure a directory connection and turn on LDAP
login. Head to [Configuration](../configuration/index.md) next.

## Verify it worked

Go to **Configuration → People → LDAP / Active Directory**
(`admin/config/people/ldap_auth/get_started`). You should land on the module's
Get Started screen, from which the connection, attribute‑mapping, and other tabs
are reachable.
