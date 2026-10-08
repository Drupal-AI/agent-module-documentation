# Installation

## Requirements

- **Drupal 8, 10, or 11** (`core_version_requirement: ^8||^10||^11`).
- The **Domain** module (`domain`) — a hard dependency, since the `domain()`
  function reads Domain's active‑domain context.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_twig -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_twig -y
```

If Domain is not yet enabled, Drupal will prompt to enable it as a dependency.

## Verify it worked

Add `{{ domain().id }}` to a template that renders on your site (for example
`page.html.twig` in your theme), clear caches, and load a page on one of your
domains. You should see that domain's id printed. Remove the test markup once you
have confirmed the function resolves.
