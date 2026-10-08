# Installation

## Requirements

- **Drupal 9.3 or newer** (`core_version_requirement: >=9.3`).
- The **Paragraphs** module (`paragraphs`) — it's a hard dependency, since the whole
  feature is a limit on a Paragraphs field. Install it too if it isn't already present:
  `composer require drupal/paragraphs -W`.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_limits -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs (if needed) and
update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_limits -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_limits -y
```

There are no submodules and no settings page. To start using it, edit a Paragraphs field
and switch its **Reference method** to *Paragraphs with limits* — see
[How to use it](../index.md#how-to-use-it) on the overview page.

## A note on uninstalling

When you uninstall the module it automatically reverts every affected field's reference
method back to the default paragraph handler and removes the per‑type limit settings, so
no orphaned configuration is left behind.
