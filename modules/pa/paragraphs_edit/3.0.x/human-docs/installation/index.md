# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Paragraphs** (`paragraphs`) module — the whole point of this module. (Paragraphs
  itself pulls in Entity Reference Revisions.)
- Core's **Contextual Links** (`contextual`) module — provides the hover links.

Drupal enables both dependencies automatically when you turn on Paragraphs Edit.
There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (If Paragraphs isn't already in your project, add it too:
`composer require drupal/paragraphs`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_edit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_edit -y
```

Enabling it (together with `contextual` and `paragraphs`) is the entire setup —
there is no configuration to do.

## Verify it worked

View a page that renders paragraphs while logged in as a user who can edit it and
who has the core **Use contextual links** permission. Hover over a paragraph and
open its contextual links; you should see **Edit paragraph**, **Clone paragraph**,
and **Delete paragraph**.
