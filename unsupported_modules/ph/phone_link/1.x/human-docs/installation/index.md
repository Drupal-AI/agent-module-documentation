# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies — Phone Link works with core's field system.

There are no third‑party Composer or PHP library requirements.

> **Note:** this project is not covered by Drupal's security advisory policy. That
> does not mean it is unsafe — it is a small display formatter with no security
> surface — but review it as you would any uncovered contrib module before using it
> on a high‑value site.

## Install with Composer

From the project root:

```bash
composer require drupal/phone_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phone_link -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phone_link -y
```

## Verify it worked

Go to **Structure → Content types → *(any type with a phone field)* → Manage
display** and confirm that **Phone link** now appears as a choice in the **Format**
dropdown for a text or telephone field. If it does, the module is installed and
ready to use.
