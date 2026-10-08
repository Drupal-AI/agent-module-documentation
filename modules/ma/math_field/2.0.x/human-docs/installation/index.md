# Installation

## Requirements

Math Field is lightweight and has no third‑party dependencies:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **text field** somewhere on your site to hold the arithmetic expression — this
  can be an existing field or one you create during setup.

There are no additional Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/math_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/math_field -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en math_field -y
```

## Verify it worked

On the Extend page (`/admin/modules`), look under the **custom** package heading —
Math Field declares itself there rather than under a content or field category.
Once it is enabled, edit a content type's **Manage display**, and the **Math field
formatter** option should be available for text fields. Enter an expression like
`(1 + 2) * 4` in a piece of content and confirm the rendered output shows the
computed result.
