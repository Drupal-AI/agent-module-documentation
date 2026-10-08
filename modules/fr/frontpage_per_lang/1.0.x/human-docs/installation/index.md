# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Language** module (`language`) enabled — this is the only dependency, and
  Drupal enables it automatically. For the module to do anything visible you need at
  least **two languages** configured, ideally with URL prefixes so language
  negotiation can pick the right front page.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/frontpage_per_lang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/frontpage_per_lang -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en frontpage_per_lang -y
```

Drupal will enable the Language dependency at the same time if it is not already on.

## Verify it worked

Add at least two languages under **Configuration → Regional and language →
Languages** if you have not already. Then go to **Configuration → System → Basic
site settings**. Under the **Front page** section you should now see a **Default
front page** textfield for each non-default language. If you only have one language,
the extra fields do not appear — that is expected. Continue to
[Configuration](../configuration/index.md) to set the paths.
