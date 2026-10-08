# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's date field support (the **Datetime** / **Datetime Range** modules) for
  the date fields you will attach the widget to.

There are **no third‑party Composer dependencies, no PHP libraries, and no
JavaScript** — the module is dependency‑free.

## Install with Composer

From the project root:

```bash
composer require drupal/drw -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drw -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drw -y
```

## Verify it worked

Go to a content type's **Manage form display**
(**Structure → Content types → *(type)* → Manage form display**) and open the
widget dropdown for a date field. **Date Range Widget** should appear as an
option. Select it, click the ⚙️ gear, and confirm you can set minimum/maximum
dates and toggle custom error messages. See the
["How to use it"](../index.md#how-to-use-it) section for configuration recipes.
