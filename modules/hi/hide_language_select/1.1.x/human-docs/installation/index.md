# Installation

## Requirements

Hide Language Select has no third‑party dependencies:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Your site should have **user‑based language selection** activated (per‑user
  language negotiation) — otherwise the language‑select field is not present and this
  module has no effect.

There are no Composer library or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hide_language_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hide_language_select -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hide_language_select -y
```

As soon as it is enabled, the language‑select field is hidden on the user form for
everyone who lacks the reveal permission — no further configuration is required.

## Verify it worked

Edit a user account (or open the registration form) as a role that does **not** have
the **Show language select on user edit form** permission — the language‑select
field should be gone. Then grant that permission to a role and confirm the field
reappears for its members.
