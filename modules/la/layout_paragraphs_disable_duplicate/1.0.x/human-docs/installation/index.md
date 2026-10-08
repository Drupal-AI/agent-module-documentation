# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Paragraphs** module (`paragraphs`).
- The **Layout Paragraphs** module (`layout_paragraphs`).

Both dependencies must be present and configured — this module only has an effect
inside the Layout Paragraphs builder. There are no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_paragraphs_disable_duplicate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update
Paragraphs and Layout Paragraphs as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_paragraphs_disable_duplicate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_paragraphs_disable_duplicate -y
```

## Verify it worked

After enabling, go to **Configuration → Content → Layout Paragraphs settings** and
confirm a new **Disable Duplicate** tab appears (or visit
`/admin/config/content/layout_paragraphs/disable-duplicate` directly). Until you
tick some paragraph types and save, nothing changes in the builder — see
[Configuration](../configuration/index.md) for the next step.
