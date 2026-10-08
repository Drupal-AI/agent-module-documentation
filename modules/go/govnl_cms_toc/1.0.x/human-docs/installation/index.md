# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No additional contrib modules or PHP libraries — it uses Drupal's block system.

## Install with Composer

From the project root:

```bash
composer require drupal/govnl_cms_toc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/govnl_cms_toc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en govnl_cms_toc -y
```

## Verify it worked

1. Confirm the settings form loads at
   **Configuration → Content authoring → GovNL Table of contents**
   (`/admin/config/content/govnl-toc`).
2. Place the **Table of contents** block under **Structure → Block layout**.
3. View a page whose content has several H2–H6 headings — the table of contents
   should render as a nested list of links that jump to each heading. (Remember
   the minimum‑threshold setting: on a page with fewer headings than the
   threshold, no table of contents appears — that is expected.)
