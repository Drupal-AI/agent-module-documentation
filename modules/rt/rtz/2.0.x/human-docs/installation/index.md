# Installation

## Requirements

Remove Trailing Zeros is a lightweight formatter with no extra dependencies:

- **Drupal 8 or newer** (`core_version_requirement: >=8`), including Drupal 10 and 11.
- No other modules, third‑party Composer libraries, or PHP extensions are required.

## Install with Composer

From the project root:

```bash
composer require drupal/rtz -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rtz -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rtz -y
```

## Verify it worked

The new formatter is available immediately. Go to a content type's **Manage
display** (**Structure → Content types → *(your type)* → Manage display**), and for
any decimal or float field open the **Format** dropdown — you should see **Remove
Trailing Zeros** listed. Select it, save, and view a piece of content: a value like
`7.000` should now render as `7`.
