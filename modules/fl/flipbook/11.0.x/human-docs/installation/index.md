# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Options**, **File**, and **Image** modules enabled — these are the dependencies,
  and Drupal enables them automatically as needed.

There are no third‑party Composer or PHP library requirements — the entire flipbook viewer
(pdf.js, three.js, Bootstrap, FontAwesome and the rest) is bundled inside the module, with no
CDN or external library to install.

## Install with Composer

From the project root:

```bash
composer require drupal/flipbook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flipbook -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flipbook -y
```

## Next steps

1. Grant the Flipbook permissions on **People → Permissions** (see the
   [main page](../index.md#how-to-use-it)).
2. Create your first flipbook at **Structure → Flipbook Listing → Add flipbook**.
3. Optionally set popup vs. inline display at **Configuration → Choose PDF style**
   (`/admin/config/choosepdfstyle`).
