# Installation

## Requirements

Simplenews needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Node**, **Field**, **Options**, and **Views** modules enabled. These are
  part of Drupal core and are enabled automatically as dependencies when you turn
  on Simplenews.
- A working **mail system**. Simplenews uses Drupal's mail delivery — for reliable
  sending of real newsletters, configure a proper mail transport (for example via
  SMTP, Symfony Mailer, or a transactional email service). This is not a hard
  install requirement, but newsletters won't reach inboxes without it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simplenews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplenews -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplenews -y
```

A default newsletter is created for you on install, so you have something to work
with straight away.

## Submodules

Simplenews ships **no submodules**.

## Uninstalling later — important

Simplenews stores subscriber data and adds fields, so it **cannot be uninstalled
directly**. Before uninstalling, go to *Configuration → Web services →
Simplenews → Settings* and use the **Prepare uninstall** form to clean up that
data first. Only then will Drupal let you uninstall the module.

## Verify it worked

Go to **Configuration → Web services → Simplenews**
(`/admin/config/services/simplenews`). You should see the newsletter list with
the default newsletter present. Next, see
[Configuration](../configuration/index.md) to attach the issue field and set up
sending.
