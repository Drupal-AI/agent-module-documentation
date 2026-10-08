# Installation

## Requirements

Filter External Link Icon is lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Filter** module (`filter`) enabled — Drupal enables it automatically as
  a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_external_link_icon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filter_external_link_icon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_external_link_icon -y
```

Enabling the module does not change any content on its own — it simply makes the
**Mark External Links** filter available to add to your text formats.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and click **Configure** on any format. In the
**Enabled filters** list you should now see **Mark External Links**. Tick it,
save, and view a piece of content that uses that format with an external link —
you should see the ↗ indicator appear after the link. See the
[main guide](../index.md#how-to-use-it) for the full walkthrough.
