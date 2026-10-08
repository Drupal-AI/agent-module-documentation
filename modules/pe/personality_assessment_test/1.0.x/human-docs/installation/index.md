# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party PHP libraries are required.
- **A `personality_assessment_test` content type** with the fields
  `field_personality_test_user_id` and `field_personality_test_result` (Full HTML
  format) — the module expects these to exist and does **not** create them. See
  "How to set it up" in the [overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/personality_assessment_test -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/personality_assessment_test -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en personality_assessment_test -y
```

## Verify it worked

With the required content type and fields in place, open **`/personality-test`**
(or place the *Personality Test Quiz* block). The 28‑question quiz should render.
Complete it and confirm a new `personality_assessment_test` node is created with
the trait percentages recorded on it.
