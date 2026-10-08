# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`; the Composer
  constraint is `drupal/core:^11`).
- Core's **Node** (`node`) and **Views** (`views`) modules — enabled on a standard
  site, and pulled in as dependencies.

No contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/xray_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/xray_audit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en xray_audit -y
```

On install, Xray Audit runs each report plugin's optional setup step (for example
creating a temporary table used by the paragraph-hierarchy report). After enabling,
grant the two permissions on **People → Permissions** — **Xray Audit access** (view
reports) and **Xray Audit administer configuration** (the settings form); both are
marked *restrict access*, so give them only to trusted roles.

## Optional submodule — Xray Audit Insight

The bundled **Xray Audit Insight** submodule (`xray_audit_insight`) turns selected
report results into warnings on Drupal's Status Report. Enable it if you want audit
findings surfaced there:

```bash
drush en xray_audit_insight -y
```

It has its own documentation under the `xray_audit_insight` module directory.
