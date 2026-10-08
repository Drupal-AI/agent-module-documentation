# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **Paragraphs Sets** module (`paragraphs_sets`) — this is a hard dependency
  and must be present and enabled. Paragraphs Sets itself depends on the
  **Paragraphs** module, so that comes along too.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_sets_plugins_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs Sets
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_sets_plugins_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_sets_plugins_ui -y
```

Drupal will enable Paragraphs Sets (and Paragraphs) automatically if they are not
already on.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then open a piece
of content that uses a Paragraphs field configured with Paragraphs Sets. The UI
for saving your current paragraph arrangement as a reusable set should now be
available.
