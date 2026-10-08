# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party PHP libraries are required by the framework itself. Individual
  **minter** modules may add their own requirements (for example an HTTP client
  or a registration‑authority account).

The base module is a framework and does very little on its own — you will almost
always pair it with at least one minter module (Handle, DataCite DOI, EZID ARK,
etc.).

## Install with Composer

From the project root:

```bash
composer require drupal/persistent_identifiers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/persistent_identifiers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en persistent_identifiers -y
```

## Add a minter

The framework needs a **minter** to actually create identifiers. Minters ship as
separate modules — for example a Handle minter, a DataCite DOI minter, or an EZID
ARK minter. Install and enable whichever one matches the registration authority
you use (each has its own Composer package and README), then configure it on the
framework's settings form. See [Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator and visit
**Configuration → Persistent Identifiers → Settings**
(`/admin/config/persistent_identifiers/settings`). The page should load with the
framework options, plus any fields added by an enabled minter. Once you have
granted the *Mint persistent identifiers* permission, open a node's edit form and
confirm the minting control appears at the bottom.
