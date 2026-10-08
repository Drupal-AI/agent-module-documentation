# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`^8.1`).
- Core's **Path Alias** module (`path_alias`) — enabled automatically as a
  dependency; it is used when the module matches the current path against your
  visibility rules.
- The Composer package also pulls in **Key** (`drupal/key`) and **CSP**
  (`drupal/csp`). Key is used by the optional dashboard submodule for storing
  API credentials, and CSP is used only if you enable the CSP‑nonce option.

You will also need a **Piwik PRO account** with an analytics container set up.
The module does not create that account for you — it connects Drupal to one that
already exists. From your Piwik PRO panel you will need your **Account ID**
(container ID) and your **tracking domain**.

## Install with Composer

From the project root:

```bash
composer require drupal/piwik_pro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/piwik_pro -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en piwik_pro -y
```

Nothing is tracked yet — the snippet only appears once you have entered your
Account ID and tracking domain on the settings form. See
[Configuration](../configuration/index.md).

## Optional submodule — Piwik Pro Dashboard

The package ships one optional submodule, **Piwik Pro Dashboard**
(`piwik_pro_dashboard`), which adds an in‑admin analytics dashboard that pulls
report data from the Piwik PRO API. Unlike the base module (which only needs the
two public identifiers), the dashboard needs real **API credentials**, stored
via the Key module. Enable it only if you want the dashboard:

```bash
drush en piwik_pro_dashboard -y
```
