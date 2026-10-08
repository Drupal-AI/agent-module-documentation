# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal's **Token** system (core token handling; the contrib
  **[Token](https://www.drupal.org/project/token)** module is commonly present too).
- **[Token Filter](https://www.drupal.org/project/token_filter)** — needed if you
  want tokens replaced inside body or text‑field output.
- **[Entity Count](https://www.drupal.org/project/entity_count)** is a recommended
  companion module.

No PHP library requirements. Note this project is **not covered by the security
advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_count_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you want in‑text token replacement, also require Token
Filter:

```bash
composer require drupal/token_filter -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_count_tokens -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_count_tokens -y
```

To use the tokens inside text fields, also enable and configure Token Filter:

```bash
drush en token_filter -y
```

## Verify it worked

Place a token such as `[entity_count_token:node:article]` somewhere token‑aware (or
in a text field whose format includes the Token Filter) and confirm it renders as
the count of Article nodes.
