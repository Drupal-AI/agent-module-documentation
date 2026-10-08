# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — the 2.1.x version, with the
  field formatter, targets Drupal 11.
- Core's **Field** module (`field`), enabled on every standard site.
- Visitors' browsers must run **JavaScript** — there is no non‑JavaScript fallback,
  so the number only appears once the decoding script runs.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/phoney -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phoney -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phoney -y
```

## Verify it worked

Set Phoney up on a text format or on a field display (see "How to use it" on the
[overview page](../index.md)), then view a page that shows an obfuscated number. In a
normal browser the number should appear as a clickable link; if you view the page
source, you should see the obscured value rather than the plain number.
