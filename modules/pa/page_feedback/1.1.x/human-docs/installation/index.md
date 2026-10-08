# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1 or newer**.
- No contributed module dependencies beyond Drupal core.
- Optional: [Honeypot](https://www.drupal.org/project/honeypot) — if enabled, the
  feedback form adds a hidden field and a timing check on top of the built‑in
  flood control.

## Install with Composer

From the project root:

```bash
composer require drupal/page_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_feedback -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_feedback -y
```

Enabling the module installs the `page_feedback` content entity and its admin
routes automatically. Nothing shows on the front end yet — that happens when you
place the block.

## Verify it worked

1. Go to **Structure → Block layout** and place the **Page feedback** block in a
   region on a content page. Reload that page as a visitor — you should see the
   "Was this page helpful?" prompt.
2. Submit an answer, then open **Content → Page feedback**
   (`/admin/content/page-feedback`) as an administrator. Your answer should appear
   in the list, newest first.

Next, if you want to reword the prompt for a particular placement, see
[Configuration](../configuration/index.md).
