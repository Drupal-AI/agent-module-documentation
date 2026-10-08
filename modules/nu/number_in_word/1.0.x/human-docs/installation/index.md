# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no module dependencies and no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/number_in_word -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/number_in_word -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en number_in_word -y
```

## Verify it worked

From Drush, confirm the service is available and returns spelled‑out text:

```bash
drush php:eval "print \Drupal::service('number_in_word.number_in_word')->number_in_word(9000);"
```

You should see the number rendered as words.
