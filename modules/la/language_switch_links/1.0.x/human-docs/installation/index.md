# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) enabled, with **more than one language**
  configured — this is the only dependency, and Drupal enables Language
  automatically if needed.

There are no third‑party Composer or PHP library requirements.

> **Note:** this project is not covered by Drupal's security advisory policy.
> That is common for very small display modules; weigh it according to your site's
> risk tolerance.

## Install with Composer

From the project root:

```bash
composer require drupal/language_switch_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_switch_links -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_switch_links -y
```

There is no required configuration.

## Verify it worked

Place the **Language switcher** block in a visible region (**Structure → Block
layout**), then view a page as a normal visitor. The switcher's links should now
read as the improved / native labels (for example "Español" rather than
"Spanish").
