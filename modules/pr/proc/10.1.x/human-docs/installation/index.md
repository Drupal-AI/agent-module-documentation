# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core modules **File**, **User**, and **Views** — part of Drupal core and
  enabled as needed.
- **OpenPGP.js** (v5) — bundled inside the module, so there is nothing separate to
  install.
- **HTTPS** in any non-localhost environment. Proc relies on the browser cache
  API, which is generally disabled without HTTPS, and client-side crypto should
  only be delivered over a trusted connection.

## Install with Composer

From the project root:

```bash
composer require drupal/proc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/proc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. DDEV serves the site over
> HTTPS, which Proc needs.

## Enable the module

```bash
drush en proc -y
```

## Optional submodules

Enable any of these individually, only if your workflow needs them:

| Submodule | Machine name |
|-----------|--------------|
| Proc Janitor | `proc_janitor` |
| Proc Metadata Transitioner | `proc_metadata_transitioner` |
| Proc Reporting | `proc_reporting` |

For example:

```bash
drush en proc_reporting -y
```

## Verify it worked

Open one of Proc's stand-alone encryption forms and encrypt a short piece of test
text, then decrypt it again with the matching key/passphrase. If the round trip
works over your HTTPS site, the client-side crypto is functioning. Only after
you're comfortable with the key-handling flow should you start encrypting real
content — remember that a lost passphrase means the data cannot be recovered.
