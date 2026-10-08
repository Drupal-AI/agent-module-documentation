# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal Commerce** 2.x or 3.x, including **Commerce Checkout**
  (`commerce_checkout`).
- The **Profile** module (`profile`) 1.x — also required by Commerce.
- **Inline Entity Form** (1.x or 3.x) — used to render the profile form; Commerce
  already relies on it.

Drupal will pull in these dependencies when you enable the module. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_profile_pane -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_profile_pane -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_profile_pane -y
```

## Set it up

Enabling the module makes the panes available but does not place any of them. To put
one to work:

1. Create the profile type you want to collect, if it does not exist yet, at
   **Configuration → People → Profile types**.
2. Go to **Commerce → Configuration → Orders → Checkout flows** and edit your
   checkout flow.
3. Move the relevant "**{Profile type}** profile form" pane into a checkout step —
   any step **except** 'login'.
4. Configure and save.

## Verify it worked

Walk through checkout on the storefront. The profile pane you placed should render
its form in the chosen step, let a customer fill it in, and — for a returning
customer who already has that profile — pre-fill it. Remember that for a profile type
allowing multiple profiles per user, the pane loads the first one found.
