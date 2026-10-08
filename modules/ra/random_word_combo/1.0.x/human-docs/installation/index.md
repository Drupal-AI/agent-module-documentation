# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed modules, PHP extensions, or third-party libraries are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/random_word_combo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/random_word_combo -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en random_word_combo -y
```

The module provides its own permission for managing word-combo sets; grant it to
the roles that should be allowed to create and flush sets on **People →
Permissions**.

## Verify it worked

Go to **Structure → Random Word Combos**. You should see the management screen
with a default set already present. Open it, generate a combination manually, and
confirm you get a memorable two-word result (for example `brave-otter`). From
here, see [How to use it](../index.md#how-to-use-it) to configure your own sets,
tokens, and uniqueness.
