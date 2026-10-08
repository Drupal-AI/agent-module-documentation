# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** system, which is part of every standard Drupal install (it powers
  text formats).
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/pirate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pirate -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pirate -y
```

Enabling the module makes the **Pirate** filter *available*, but it does nothing until
you switch it on for a text format.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), configure a text format, and enable the **Pirate**
filter (see [How to use it](../index.md#how-to-use-it)). Save, then view a piece of
content that uses that format — the text should now read in pirate speak. Yarr!
