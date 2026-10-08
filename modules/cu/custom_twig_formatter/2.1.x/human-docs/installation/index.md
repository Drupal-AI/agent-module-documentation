# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Drupal core's **Field** module (`field`) — enabled on virtually every Drupal
  site, and Drupal ensures it's on as a dependency.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_twig_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_twig_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_twig_formatter -y
```

## Verify it worked

Go to a **Manage display** screen (for example **Structure → Content types →
*(your type)* → Manage display**), set a field's **Format** to **Custom Twig
Formatter**, and enter a small piece of Twig in its settings. Save and view an
entity to confirm the field renders using your Twig. See
["How to use it"](../index.md#how-to-use-it) for details — and note the
trusted-administrator caution there before granting anyone access to these screens.
