# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) enabled — part of the standard install and the
  only module dependency.
- The **CommonMark** library (`league/commonmark`, `^2.4`) — Composer installs this
  for you; it's what does the Markdown‑to‑HTML conversion.

There are no other requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/markdown_easy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the CommonMark
library and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markdown_easy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markdown_easy -y
```

There are no submodules and no permissions to grant. After enabling, add the
**Markdown Easy** filter to a text format (or use the ready‑made **markdown** format)
— see the [main guide](../index.md#how-to-use-it). Remember the filter must run
*before* core's "Limit allowed HTML tags" filter; the module enforces this for you.
