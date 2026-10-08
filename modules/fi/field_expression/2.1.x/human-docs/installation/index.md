# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement: ^10.2 ||
  ^11`). Note this is stricter than the 2.0.x line, which also supports
  Drupal 9.
- The **Token** module (`drupal/token`, `^1`) — a dependency, and needed for
  expressions that read values from other fields.
- The **`webit/eval-math`** PHP library (`^1.0`) — the sandboxed math evaluator
  that parses expressions. Composer installs it automatically as a requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/field_expression -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and the `webit/eval-math` library and update any shared dependencies as needed.
Installing via Composer is important here, because the `webit/eval-math` library
must be present — a manual download of just the module folder will not include it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_expression -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_expression token -y
```

This enables both Expression Field and the recommended Token module in one
command.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**
and confirm that the **Expression** field types appear — the base Expression
field plus the typed integer, decimal, and float variants. Add one, give it a
simple expression (for example a token multiplied by a number), save a piece of
content, and check that the stored, computed value renders and — for a numeric
variant — sorts as a number.
