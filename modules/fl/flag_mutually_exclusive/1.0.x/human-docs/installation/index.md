# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3`).
- The **Flag** module (`flag`), version **5.0.0 or later** — this module listens
  to Flag's events and is installed alongside it.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_mutually_exclusive -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_mutually_exclusive -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_mutually_exclusive -y
```

This also enables the Flag module if it isn't already on.

## Verify it worked

Create two flags in the Flag module (**Structure → Flags**,
`/admin/structure/flags`) that apply to the same entity type, then pair them in
the Flag mutually exclusive admin UI. Set one flag on an entity and then the
other — the first should be unset automatically, confirming the exclusion is
working.
