# Installation

## Requirements

Term Reference Change is deliberately lightweight. It needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — this is the only dependency,
  and Drupal enables it automatically when you turn on Term Reference Change.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/term_reference_change -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_reference_change -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_reference_change -y
```

That is all it takes. Remember that enabling the module has **no visible effect** —
it adds no admin pages, no settings and no permissions. It simply makes its two
services available to other modules and to your own code.

## Verify it worked

There is no UI to check, so confirm from the command line:

```bash
drush pm:list --status=enabled | grep term_reference_change
```

To prove the services are wired up, count the references to a term:

```bash
drush php:eval '
  $refs = \Drupal::service("term_reference_change.reference_finder")
    ->findReferencesFor(\Drupal\taxonomy\Entity\Term::load(1));
  print array_sum(array_map("count", $refs)) . " entities reference term 1\n";
'
```

For the service signatures and how to actually merge terms in bulk, see the
[`agent/`](../agent/start.md) reference docs.
