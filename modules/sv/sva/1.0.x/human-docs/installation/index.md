# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Views** module (`views`), which is part of the standard Drupal install.
- No third-party Composer packages or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/sva -W
```

> **Package name vs. machine name.** The Composer package is **`drupal/sva`**, but
> the module's machine name — what you enable and see in the UI — is
> **`simple_views_accordion`**. That mismatch is expected.

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sva -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_views_accordion -y
```

## Verify it worked

Edit any View at **Structure → Views** and open its **Format** settings. With the
module enabled, **Simple Views Accordion** should appear as a selectable display
format.

> **Note:** This release is a beta (1.0.0-beta3) and is not covered by Drupal's
> security advisory policy. Review it before relying on it in production.
