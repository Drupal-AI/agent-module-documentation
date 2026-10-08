# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** (`block`) and **System** (`system`) modules — both are part of
  a standard Drupal install and are enabled automatically as dependencies.
- A running **n8n instance** with a chat workflow whose webhook URL you can copy.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/n8n_chat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/n8n_chat -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

This is an alpha release (1.0.0‑alpha1) and is not covered by Drupal's security
advisory policy, so test it on a non‑production site first.

## Enable the module

```bash
drush en n8n_chat -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to paste in
your n8n webhook URL. The chat widget only appears once a valid webhook is
configured and you have either enabled the global widget or placed the **n8n
Chat** block.
