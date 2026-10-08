# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) — the shared base for all Extra Paragraph Types modules.
- **Paragraphs** (`paragraphs`).
- A **Bootstrap‑based theme** (or Bootstrap's CSS classes otherwise available), so
  the button's emitted classes are styled. This is not a hard install dependency,
  but the button renders unstyled without it.

Composer pulls the contributed dependencies (`ept_core` and Paragraphs) in for you
with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_bootstrap_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `ept_core` and Paragraphs alongside this
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_bootstrap_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_bootstrap_button -y
```

Drupal will enable `ept_core` and Paragraphs too if they aren't already on.

## Verify it worked

Edit content that has a Paragraphs field allowing the Bootstrap Button type (or add
such a field first). Add a **Bootstrap Button** paragraph, set its link and choose a
Bootstrap variant, and save — on a Bootstrap‑based theme it should render as a
styled button. If it looks unstyled, confirm your theme provides Bootstrap's button
classes.
