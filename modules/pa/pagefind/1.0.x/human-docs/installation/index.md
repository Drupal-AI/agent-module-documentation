# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1 or higher.**
- A **private file system** — `$settings['file_private_path']` must be configured. It's
  used for content staging and to hold the Pagefind binary, which is deliberately never
  web‑accessible.
- **Outbound HTTPS to GitHub releases**, so the module can automatically download the
  checksum‑verified Pagefind binary. If your host blocks outbound traffic, you can supply
  your own binary instead.
- Depends only on Drupal core: **Node**, **System**, **Path alias** and **Views**. Media
  and Taxonomy support switch on automatically when those modules are enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/pagefind -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagefind -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagefind -y
```

## Set the permission

Grant the **Administer pagefind index** permission to the roles that should manage the
search index and its settings, at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Open the **Pagefind dashboard** from the admin menu. From there, launch the built‑in
**Setup Wizard** to reach a working search page, then build the index — see
[Configuration](../configuration/index.md) for the full walkthrough. The module ships
Drush tooling with diagnostics, which is handy for confirming the binary downloaded and
the index built correctly.
