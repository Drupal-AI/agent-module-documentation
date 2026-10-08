# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only module dependency.
- The **CommonMark** PHP library (`league/commonmark`), which performs the
  Markdown‑to‑HTML conversion. Installing the module with Composer pulls this in
  automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_process_markdown_to_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the CommonMark
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_process_markdown_to_html -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_process_markdown_to_html -y
```

Core Migrate is enabled automatically if it is not already on.

## Verify it worked

Confirm the module is enabled (**Extend** page, or
`drush pm:list --status=enabled`). There is no settings form to check — the
`markdown_to_html` process plugin becomes available for use in your migration
YAML (see "How to use it" on the [overview page](../index.md)).
