# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Path alias** module (`path_alias`) — enabled by default in Drupal 10+.
- Core's **Menu link** module (`menu_link_content`) — enabled by default in
  Drupal 10+.

## Install with Composer

From the project root:

```bash
composer require drupal/page_swap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_swap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_swap -y
```

## Submodules

- **Swap History** (`page_swap_history`) — optional. Enable it if you want a
  timestamped, per‑user audit log of every swap operation, shown in a dedicated
  administration tab:

  ```bash
  drush en page_swap_history -y
  ```

## Grant the permission

Under **People → Permissions** (`/admin/people/permissions`), grant **Use Page
Swap** to the administrator roles that should be allowed to perform swaps. The
permission is marked *restrict access* because a swap has irreversible effects on
public URLs and site structure — assign it only to trusted roles.

## Verify it worked

Go to **Configuration → Content authoring → Page Swap**
(`/admin/config/content/page-swap`). You should see the swap form with autocomplete
fields for the original and replacement pages. See
[Configuration](../configuration/index.md) for how to perform a swap.
