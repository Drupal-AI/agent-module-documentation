# Installation

## Requirements

Response Code Conditions is lightweight. It needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Drupal core's condition/block system — no other modules, and no third‑party
  Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/response_code_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/response_code_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en response_code_condition -y
```

That's all it takes. The new **Response code** condition is now available
wherever Drupal conditions are — most commonly on a block's **Visibility** tab.

## Verify it worked

Go to **Structure → Block layout**, place or edit a block, and open its
**Visibility** settings. You should see a **Response code** section with a
textarea for entering status codes. Enter `404`, save, and visit a non‑existent
URL — the block should appear on the 404 page and nowhere else.
