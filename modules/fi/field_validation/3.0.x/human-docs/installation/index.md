# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.0 or newer**.
- Core's **Field** module (`field`), which is enabled on any standard Drupal site.
- Two Symfony libraries — **symfony/expression-language** (`^6.3`) and
  **symfony/intl** (`^6.3`) — which power the expression and locale/country
  constraint rules. Composer installs them for you automatically.

Note that the installed 3.0.x release is a **beta** (3.0.0-beta7). This branch is
a rewrite that maps Drupal/Symfony validation constraints onto fields; test it
before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/field_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
Symfony libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_validation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_validation -y
```

Then grant the **Administer field validation rule set** permission to the roles
that should manage rules (People → Permissions). This single permission is marked
as a restricted access permission and gates the entire rule-set UI.

## The legacy submodule

Field Validation ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Field Validation Legacy** | `field_validation_legacy` | Roughly 20 of the older, hand-written rule plugins from the 8.x/1.x era — pattern, phone, words blocklist, plain-text, item-count, and similar. Enable it only if you are upgrading a site that relied on those specific rules. |

```bash
drush en field_validation_legacy -y
```

New sites generally do not need the legacy submodule — the constraint-backed rules
in the main module cover most needs.
