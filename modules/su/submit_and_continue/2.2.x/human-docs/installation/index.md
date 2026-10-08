# Installation

## Requirements

Submit and continue is deliberately simple:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No module dependencies, and no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/submit_and_continue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/submit_and_continue -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en submit_and_continue -y
```

## Verify it worked

Open a form where you add repeated content — for example the "add content" form for
a content type — and look for the **Submit and continue** action. Submitting with
it should return you to a fresh, empty copy of the same form, ready for the next
entry. The button labels and their return routes are defined in the module's YAML
configuration, which you can adjust with a configuration override if the defaults
do not suit you.
