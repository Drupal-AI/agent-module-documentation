# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.
- Your site's **domains registered with OneGov** — the feedback and sentiment
  widgets rely on this to work.

There are no third‑party Composer or PHP library requirements. Note the release
documented here is a beta (2.0.0‑beta5).

## Install with Composer

From the project root:

```bash
composer require drupal/nsw_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nsw_feedback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nsw_feedback -y
```

## Submodules

- **`nsw_feedback_assist`** — an optional submodule. Enable it if you want the
  additional behaviour it provides:

  ```bash
  drush en nsw_feedback_assist -y
  ```

  It requires the base NSW Feedback module, which is already present once you have
  installed it above.

## Verify it worked

Go to **Structure → Block layout** and confirm the OneGov feedback (and, in 2.x,
sentiment) blocks are available to place. Place a block, set the custom
JavaScript path if you need one, and load a page where the block appears — the
OneGov widget should render. If it does not, the most common cause is that the
site's domain is **not yet registered with OneGov**, which the widgets require.
