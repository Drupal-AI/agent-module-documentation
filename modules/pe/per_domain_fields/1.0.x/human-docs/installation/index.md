# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Domain** module (`domain`, i.e. Domain Access). This is required — the whole
  point of the module is storing values per Domain‑module domain. Composer installs
  it as a dependency.

There are no third‑party Composer or PHP library requirements.

> **Heads up:** this project is **not covered by Drupal's security advisory
> policy**. Review it as you would any uncovered contrib module before relying on it
> in production.

## Install with Composer

From the project root:

```bash
composer require drupal/per_domain_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed, and it brings in the Domain module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/per_domain_fields -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en per_domain_fields domain -y
```

Make sure your domains are set up in the Domain module before you start entering
per‑domain values.

## Verify it worked

Go to **Structure → Content types → *(a content type)* → Manage fields → Add
field**. The list of available field types should now include the **"… [Per‑domain]"**
variants. Add one, then edit a piece of content — the field's widget should repeat
once for each configured domain, letting you enter a separate value per domain.
