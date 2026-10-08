# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Workflows** module (`workflows`).
- Core's **Content Moderation** module (`content_moderation`), configured with at
  least one workflow applied to your content — the bulk action operates on the
  states and transitions that workflow defines.

Drupal will enable the Workflows and Content Moderation dependencies automatically.
There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_bulk_state_change -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_bulk_state_change -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_bulk_state_change -y
```

After installation, a bulk action is enabled on content views automatically.

## Verify it worked

Open your content admin listing as an editor with the **"Update entity moderation
states in bulk"** permission. In the bulk-operations dropdown you should now see the
**"Change workflow stage"** action. Select a couple of nodes, choose the action, then
on the confirm form pick a target state and confirm — the selected content moves to
that state. To tune the action and its permissions, see
[Configuration](../configuration/index.md).
