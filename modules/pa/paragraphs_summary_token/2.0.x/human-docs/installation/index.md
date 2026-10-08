# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Paragraphs** module (`paragraphs`) version 1 and the **Token** module
  (`token`) version 1 — both are required dependencies and Drupal enables them
  automatically.
- Core's **Image** module — only needed for the `image` token. The `summary`
  token works without it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_summary_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
Token (and update any shared dependencies) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_summary_token -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_summary_token -y
```

This also enables Paragraphs and Token if they were not already on. The module
ships no submodules and has no configuration page — once enabled, the summary
and image tokens are available on any entity with a Paragraphs field. See the
[overview](../index.md#how-to-use-it) for how to use them.
